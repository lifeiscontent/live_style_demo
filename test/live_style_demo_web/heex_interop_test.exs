defmodule LiveStyleDemoWeb.HeexInteropTest do
  use ExUnit.Case, async: true

  defmodule LocalStyles do
    use LiveStyle

    class(:base, color: "#0f172a")
    class(:active, background_color: "#dbeafe")
    class(:dynamic_opacity, fn opacity -> [opacity: opacity] end)

    def eval(template, assigns \\ %{}) do
      opts = [file: __ENV__.file, caller: __ENV__, tag_handler: Phoenix.LiveView.HTMLEngine]
      quoted = Phoenix.LiveView.TagEngine.compile(template, opts)
      {rendered, _} = Code.eval_quoted(quoted, [assigns: assigns], __ENV__)
      rendered
    end
  end

  test "resolves local atom refs into static class strings" do
    base = Keyword.fetch!(LocalStyles.__live_style__(:class_strings), :base)
    active = Keyword.fetch!(LocalStyles.__live_style__(:class_strings), :active)

    rendered = LocalStyles.eval(~S(<div class={[:base, :active]} />))

    assert %Phoenix.LiveView.Rendered{} = rendered
    assert rendered.static == ["<div class=\"#{base} #{active}\"></div>"]
  end

  test "keeps conditional refs dynamic while preserving static prefix" do
    base = Keyword.fetch!(LocalStyles.__live_style__(:class_strings), :base)

    rendered =
      LocalStyles.eval(~S(<div class={[:base, @enabled && :active]} />), %{enabled: true})

    assert %Phoenix.LiveView.Rendered{} = rendered
    assert rendered.static == ["<div class=\"#{base} ", "\"></div>"]
  end

  test "resolves tuple refs including nested lists" do
    module_ref =
      Keyword.fetch!(LiveStyleDemoWeb.SharedStyles.__live_style__(:class_strings), :module_ref)

    list_ref =
      Keyword.fetch!(LiveStyleDemoWeb.SharedStyles.__live_style__(:class_strings), :list_ref)

    rendered =
      LocalStyles.eval(
        ~S(<div class={[{LiveStyleDemoWeb.SharedStyles, :module_ref}, [{LiveStyleDemoWeb.SharedStyles, :list_ref}]]} />)
      )

    assert %Phoenix.LiveView.Rendered{} = rendered
    assert rendered.static == ["<div class=\"#{module_ref} #{list_ref}\"></div>"]
  end

  test "inlines local dynamic mfa refs as static class + style when args are static" do
    expected = LiveStyle.resolve_attrs(LocalStyles, [{:dynamic_opacity, [opacity: 0.5]}], nil)
    rendered = LocalStyles.eval(~S(<div class={[{:dynamic_opacity, opacity: 0.5}]} />))

    assert %Phoenix.LiveView.Rendered{} = rendered

    assert rendered.static == [
             "<div class=\"#{expected.class}\" style=\"#{expected.style}\"></div>"
           ]

    assert is_function(rendered.dynamic, 1)
    assert rendered.dynamic.(true) == []
  end

  test "inlines module dynamic mfa refs as static class + style when args are static" do
    expected =
      LiveStyle.resolve_attrs(
        LiveStyleDemoWeb.SharedStyles,
        [{:dynamic_opacity, [opacity: 0.35]}],
        nil
      )

    rendered =
      LocalStyles.eval(
        ~S(<div class={[{LiveStyleDemoWeb.SharedStyles, :dynamic_opacity, opacity: 0.35}]} />)
      )

    assert %Phoenix.LiveView.Rendered{} = rendered

    assert rendered.static == [
             "<div class=\"#{expected.class}\" style=\"#{expected.style}\"></div>"
           ]

    assert is_function(rendered.dynamic, 1)
    assert rendered.dynamic.(true) == []
  end

  test "keeps dynamic mfa style values dynamic while class stays static" do
    class_name = Keyword.fetch!(LocalStyles.__live_style__(:class_strings), :dynamic_opacity)

    rendered =
      LocalStyles.eval(~S(<div class={[{:dynamic_opacity, opacity: @opacity}]} />), %{
        opacity: 0.7
      })

    assert %Phoenix.LiveView.Rendered{} = rendered
    assert rendered.static == ["<div class=\"#{class_name}\" style=\"", "\"></div>"]
  end
end
