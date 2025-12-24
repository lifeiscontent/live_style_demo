defmodule LiveStyleDemoWeb.GuardrailsTest do
  use ExUnit.Case, async: true

  @tokens_file Path.expand("../../lib/live_style_demo_web/tokens.ex", __DIR__)

  # OKLab ΔE ranges 0..~1. This threshold is tuned to catch
  # near-identical swatches (like Secondary == Surface) without
  # rejecting intentionally-adjacent hues (like Swiss primary vs danger).
  @min_delta_e 0.04

  test "semantic fill palette stays distinct per theme" do
    themes = semantic_themes(@tokens_file)

    required_keys = ~w(fill_primary fill_secondary fill_surface fill_danger)

    for {theme, values} <- themes do
      for key <- required_keys do
        assert Map.has_key?(values, key), "#{theme} is missing :#{key}"
      end

      palette = Enum.map(required_keys, &Map.fetch!(values, &1))

      assert Enum.uniq(palette) == palette,
             "#{theme} fill palette has duplicates: #{inspect(palette)}"

      # Perceptual distinctness guardrail (OKLab ΔE).
      colors = Enum.map(palette, &hex_to_oklab!/1)

      for {a, i} <- Enum.with_index(colors),
          {b, j} <- Enum.with_index(colors),
          i < j do
        delta = delta_e(a, b)

        assert delta >= @min_delta_e,
               "#{theme} fill palette has low OKLab ΔE (#{Float.round(delta, 4)}) between #{Enum.at(required_keys, i)} and #{Enum.at(required_keys, j)}"
      end
    end
  end

  defp hex_to_oklab!("#" <> hex) when byte_size(hex) == 6 do
    {r, g, b} =
      hex
      |> String.upcase()
      |> Base.decode16!()
      |> then(fn <<r, g, b>> -> {r / 255, g / 255, b / 255} end)

    {l, m, s} =
      {srgb_to_linear(r), srgb_to_linear(g), srgb_to_linear(b)}
      |> linear_rgb_to_lms()

    oklab_from_lms(l, m, s)
  end

  defp srgb_to_linear(c) when c <= 0.04045, do: c / 12.92
  defp srgb_to_linear(c), do: :math.pow((c + 0.055) / 1.055, 2.4)

  # OKLab conversion per Björn Ottosson.
  defp linear_rgb_to_lms({r, g, b}) do
    l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
    m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
    s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b
    {l, m, s}
  end

  defp oklab_from_lms(l, m, s) do
    l_ = :math.pow(l, 1.0 / 3.0)
    m_ = :math.pow(m, 1.0 / 3.0)
    s_ = :math.pow(s, 1.0 / 3.0)

    l_ok = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_
    a_ok = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_
    b_ok = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_

    {l_ok, a_ok, b_ok}
  end

  defp delta_e({l1, a1, b1}, {l2, a2, b2}) do
    dl = l1 - l2
    da = a1 - a2
    db = b1 - b2
    :math.sqrt(dl * dl + da * da + db * db)
  end

  test "LiveViews do not reference component style atoms" do
    live_dir = Path.expand("../../lib/live_style_demo_web/live", __DIR__)

    offenders =
      live_dir
      |> Path.join("*_live.ex")
      |> Path.wildcard()
      |> Enum.flat_map(fn path ->
        contents = File.read!(path)

        patterns = [
          ~r/\{\s*UIComponents\s*,\s*:/,
          ~r/\{\s*LayoutComponents\s*,\s*:/,
          ~r/require\s+LiveStyleDemoWeb\.UIComponents\b/,
          ~r/require\s+LiveStyleDemoWeb\.LayoutComponents\b/,
          ~r/alias\s+LiveStyleDemoWeb\.(UIComponents|LayoutComponents)\b/
        ]

        if Enum.any?(patterns, &Regex.match?(&1, contents)) do
          [Path.relative_to_cwd(path)]
        else
          []
        end
      end)

    assert offenders == [], "Found LiveView style-atom offenders: #{inspect(offenders)}"
  end

  defp semantic_themes(tokens_file) do
    tokens_file
    |> File.read!()
    |> parse_semantic_blocks()
    |> Map.new(fn {theme, body} ->
      {theme, extract_kv(body)}
    end)
  end

  defp parse_semantic_blocks(source) do
    # Captures:
    # - base: css_vars(:semantic, ...)
    # - overrides: css_theme(:semantic, :navy, ...)
    regex =
      ~r/\bcss_(?:vars|theme)\(:semantic(?:,\s*:(\w+))?,\s*(.*?)\n\s*\)\n/ms

    Regex.scan(regex, source)
    |> Enum.reduce(%{}, fn
      [_full, theme, body], acc ->
        theme = if theme in [nil, ""], do: "default", else: theme
        Map.put(acc, theme, body)

      _other, acc ->
        acc
    end)
  end

  defp extract_kv(body) do
    body
    |> String.split("\n")
    |> Enum.reduce(%{}, fn line, acc ->
      case Regex.run(~r/^\s*(\w+):\s*"([^"]+)"\s*,?\s*$/, line) do
        [_, key, value] ->
          Map.put(acc, key, value)

        _ ->
          acc
      end
    end)
  end
end
