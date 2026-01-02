defmodule LiveStyleDemoWeb.ColorLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Anim
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:layout,
    display: "grid",
    gap: var({Space, :"8"}),
    grid_template_columns: [
      default: "1fr",
      "@media (min-width: 900px)": "1.2fr 0.8fr"
    ]
  )

  class(:card,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.15)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 26px 80px -74px #{var({Semantic, :shadow_color_strong})}",
    padding: var({Space, :"6"})
  )

  class(:title,
    font_size: const({Tokens, :font_size_xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    margin_bottom: var({Space, :"2"})
  )

  class(:subtitle,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed}),
    margin_bottom: var({Space, :"6"})
  )

  class(:tip,
    margin: "0",
    color: var({Semantic, :text_muted}),
    font_size: const({Tokens, :font_size_sm})
  )

  class(:palette_grid,
    display: "grid",
    grid_template_columns: "repeat(3, 1fr)",
    grid_template_rows: "repeat(2, 1fr)",
    gap: var({Space, :"4"}),
    height: "min(46vh, 420px)"
  )

  class(:color_block,
    border_radius: const({Tokens, :radius_xl}),
    border: "1px solid #{var({Semantic, :border_glass})}",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_on_primary}),
    font_family: const({Tokens, :font_mono}),
    transition: "background-color 200ms ease"
  )

  # Color Variants (calculated via color-mix)
  class(:color_base,
    grid_column: "span 2",
    grid_row: "span 2",
    background_color: "oklch(70% #{var({Anim, :chroma})} #{var({Anim, :hue})})"
  )

  class(:color_dark,
    background_color:
      "color-mix(in oklab, oklch(70% #{var({Anim, :chroma})} #{var({Anim, :hue})}) 60%, black)"
  )

  class(:color_light,
    background_color:
      "color-mix(in oklab, oklch(70% #{var({Anim, :chroma})} #{var({Anim, :hue})}) 60%, white)",
    color: var({Semantic, :text_primary})
  )

  class(:swatch_vars, fn hue, chroma ->
    [
      {var({Anim, :hue}), hue},
      {var({Anim, :chroma}), chroma}
    ]
  end)

  class(:controls,
    display: "grid",
    gap: var({Space, :"4"})
  )

  class(:label,
    display: "flex",
    align_items: "baseline",
    justify_content: "space-between",
    gap: var({Space, :"3"}),
    font_weight: const({Tokens, :font_weight_medium}),
    color: var({Semantic, :text_primary})
  )

  class(:value,
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary})
  )

  class(:range,
    width: "100%",
    accent_color: var({Semantic, :fill_primary})
  )

  class(:code,
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_sm}),
    line_height: const({Tokens, :leading_relaxed}),
    white_space: "pre-wrap",
    color: var({Semantic, :text_secondary}),
    background_color: var({Semantic, :fill_muted}),
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_lg}),
    padding: var({Space, :"4"})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Color & OKLCH")
     |> assign(hue: 260, chroma: 0.22)
     |> push_event("start-view-transition", %{type: "page"}, dispatch: :before)}
  end

  @impl true
  def handle_event("update", %{"hue" => hue, "chroma" => chroma}, socket) do
    {:noreply,
     socket
     |> assign(hue: String.to_integer(hue))
     |> assign(chroma: String.to_float(chroma))}
  end

  defp code_snippet(assigns) do
    ~H"""
    <pre {css(:code)}>
    /* Base Color */
    background: oklch(70% {Float.round(@chroma, 2)} {@hue}deg);

    /* Darker Variant */
    background: color-mix(
      in oklab,
      oklch(70% {Float.round(@chroma, 2)} {@hue}deg),
      black 40%
    );

    /* With CSS Variables */
    @property {LiveStyle.Vars.fetch!({Tokens.Anim, :hue})[:ident]} &#123;
      syntax: "&lt;angle&gt;";
      inherits: true;
      initial-value: 260deg;
    &#125;
    </pre>
    """
  end

  @impl true
  def render(assigns) do
    assigns =
      assigns
      |> assign(:chroma_string, :erlang.float_to_binary(assigns.chroma, decimals: 2))

    ~H"""
    <.shell
      active="color"
      page_title="Color & OKLCH"
      page_subtitle="OKLCH + color-mix() + typed custom properties (@property)."
    >
      <div {css(:layout)}>
        <div {css(:card)}>
          <div {css(:title)}>Palette Generator</div>
          <p {css(:subtitle)}>
            Generate a color scale on the fly using <code>oklch()</code> and <code>color-mix()</code>.
            Solid colors only—no gradients.
          </p>

          <div {css([:palette_grid, {:swatch_vars, ["#{@hue}deg", @chroma_string]}])}>
            <div {css([:color_block, :color_base])}>Base</div>
            <div {css([:color_block, :color_dark])}>Darker</div>
            <div {css([:color_block, :color_light])}>Lighter</div>
          </div>

          <form phx-change="update" phx-submit="update" {css(:controls)}>
            <div>
              <div {css(:label)}>
                <span>Hue</span>
                <span {css(:value)}>{@hue}</span>
              </div>
              <input
                {css(:range)}
                name="hue"
                type="range"
                min="0"
                max="360"
                value={@hue}
                phx-debounce="50"
              />
            </div>

            <div>
              <div {css(:label)}>
                <span>Chroma</span>
                <span {css(:value)}>{@chroma_string}</span>
              </div>
              <input
                {css(:range)}
                name="chroma"
                type="range"
                min="0.05"
                max="0.35"
                step="0.01"
                value={@chroma_string}
                phx-debounce="50"
              />
            </div>

            <p {css(:tip)}>
              Tip: use the header theme picker (◐) or press <code>t</code>.
            </p>
          </form>
        </div>

        <div {css(:card)}>
          <div {css(:title)}>What's happening</div>
          <p {css(:subtitle)}>
            We set hue and chroma via a dynamic <code>class/2</code>
            rule that writes
            the hashed custom properties (using <code>var/1</code>
            as the property key), then reference
            both variables inside the static color definition.
            LiveStyle generates the <code>@property</code>
            rule from typed tokens.
          </p>

          <.code_snippet hue={@hue} chroma={@chroma} />
        </div>
      </div>
    </.shell>
    """
  end
end
