defmodule LiveStyleDemoWeb.ColorLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens

  css_class(:layout,
    display: "grid",
    gap: css_var({Tokens, :space, :"8"}),
    grid_template_columns: [
      default: "1fr",
      "@media (min-width: 900px)": "1.2fr 0.8fr"
    ]
  )

  css_class(:card,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.15)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 26px 80px -74px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    padding: css_var({Tokens, :space, :"6"})
  )

  css_class(:title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_class(:subtitle,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    margin_bottom: css_var({Tokens, :space, :"6"})
  )

  css_class(:tip,
    margin: "0",
    color: css_var({Tokens, :semantic, :text_muted}),
    font_size: css_const({Tokens, :font_size, :sm})
  )

  css_class(:swatch,
    height: "min(46vh, 420px)",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    overflow: "hidden",
    position: "relative",
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    background_image:
      "radial-gradient(700px circle at 10% 10%, color-mix(in oklab, oklch(70% #{css_var({Tokens, :anim, :chroma})} #{css_var({Tokens, :anim, :hue})}) 45%, transparent), transparent 55%), radial-gradient(700px circle at 90% 20%, color-mix(in oklab, oklch(74% #{css_var({Tokens, :anim, :chroma})} calc(#{css_var({Tokens, :anim, :hue})} + 60deg)) 42%, transparent), transparent 60%), linear-gradient(180deg, color-mix(in oklab, oklch(20% 0.06 calc(#{css_var({Tokens, :anim, :hue})} + 200deg)) 65%, transparent), transparent)",
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})} inset, 0 22px 80px -72px #{css_var({Tokens, :semantic, :shadow_color_strong})}"
  )

  css_class(:swatch_vars, fn hue, chroma ->
    [
      {css_var({Tokens, :anim, :hue}), hue},
      {css_var({Tokens, :anim, :chroma}), chroma}
    ]
  end)

  css_class(:swatch_overlay,
    position: "absolute",
    inset: "0",
    background_image:
      "linear-gradient(135deg, rgba(255, 255, 255, 0.20), transparent 40%), repeating-linear-gradient(90deg, rgba(255,255,255,0.08) 0 1px, transparent 1px 6px)",
    mix_blend_mode: "overlay",
    opacity: "0.85",
    pointer_events: "none"
  )

  css_class(:controls,
    display: "grid",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:label,
    display: "flex",
    align_items: "baseline",
    justify_content: "space-between",
    gap: css_var({Tokens, :space, :"3"}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:value,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  css_class(:range,
    width: "100%",
    accent_color: css_var({Tokens, :semantic, :fill_primary})
  )

  css_class(:code,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    white_space: "pre-wrap",
    color: css_var({Tokens, :semantic, :text_secondary}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"4"})
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
    <pre class={css_class([:code])}>
    oklch(70% {Float.round(@chroma, 2)} {@hue}deg)

    /* with CSS variables */
    @property {LiveStyle.Vars.lookup!(Tokens, :anim, :hue)} &#123; syntax: "&lt;angle&gt;"; inherits: true; initial-value: 260deg; &#125;
    @property {LiveStyle.Vars.lookup!(Tokens, :anim, :chroma)} &#123; syntax: "&lt;number&gt;"; inherits: true; initial-value: 0.22; &#125;
    /* Set at runtime via dynamic css_class(:swatch_vars, ...) */
    {LiveStyle.Vars.lookup!(Tokens, :anim, :hue)}: {@hue}deg;
    {LiveStyle.Vars.lookup!(Tokens, :anim, :chroma)}: {Float.round(@chroma, 2)};

    color-mix(in oklab, oklch(70% {css_var({Tokens, :anim, :chroma})} {css_var({Tokens, :anim, :hue})}) 45%, transparent)
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
      <div class={css_class([:layout])}>
        <div class={css_class([:card])}>
          <div class={css_class([:title])}>Interactive OKLCH palette</div>
          <p class={css_class([:subtitle])}>
            This swatch is built from layered gradients that use <code>oklch()</code>
            and <code>color-mix(in oklab, ...)</code>.
            The hue is stored in a typed custom property, so it animates smoothly.
          </p>

          <div {css([:swatch, {:swatch_vars, ["#{@hue}deg", @chroma_string]}])}>
            <div class={css_class([:swatch_overlay])} />
          </div>

          <form phx-change="update" phx-submit="update" class={css_class([:controls])}>
            <div>
              <div class={css_class([:label])}>
                <span>Hue</span>
                <span class={css_class([:value])}>{@hue}</span>
              </div>
              <input
                class={css_class([:range])}
                name="hue"
                type="range"
                min="0"
                max="360"
                value={@hue}
                phx-debounce="50"
              />
            </div>

            <div>
              <div class={css_class([:label])}>
                <span>Chroma</span>
                <span class={css_class([:value])}>{@chroma_string}</span>
              </div>
              <input
                class={css_class([:range])}
                name="chroma"
                type="range"
                min="0.05"
                max="0.35"
                step="0.01"
                value={@chroma_string}
                phx-debounce="50"
              />
            </div>

            <p class={css_class([:tip])}>
              Tip: use the header theme picker (◐) or press <code>t</code>.
            </p>
          </form>
        </div>

        <div class={css_class([:card])}>
          <div class={css_class([:title])}>What’s happening</div>
          <p class={css_class([:subtitle])}>
            We set hue and chroma via a dynamic <code>css_class/2</code>
            rule that writes
            the hashed custom properties (using <code>css_var/1</code>
            as the property key), then reference

            both variables inside the static gradient definition.
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
