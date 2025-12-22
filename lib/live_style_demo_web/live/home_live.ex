defmodule LiveStyleDemoWeb.HomeLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.BaseStyles
  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  css_class(:hero,
    padding_block: css_var({Tokens, :space, :"16"}),
    text_align: "center"
  )

  css_class(:hero_inner,
    max_width: "70rem",
    margin_inline: "auto",
    display: "grid",
    gap: css_var({Tokens, :space, :"6"}),
    justify_items: "center"
  )

  css_class(:badge,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"1.5"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border_radius: css_const({Tokens, :radius, :full}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    color: css_var({Tokens, :semantic, :text_secondary}),
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium})
  )

  css_class(:hero_title,
    font_size: "clamp(2.25rem, 1.75rem + 2.6vw, 4rem)",
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.03em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:hero_gradient,
    background_image: css_const({Tokens, :gradient, :hero}),
    background_clip: "text",
    "-webkit-text-fill-color": "transparent"
  )

  css_class(:hero_subtitle,
    max_width: "70ch",
    margin_inline: "auto",
    font_size: css_const({Tokens, :font_size, :lg}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:cta_row,
    display: "flex",
    flex_wrap: "wrap",
    justify_content: "center",
    gap: css_var({Tokens, :space, :"3"})
  )

  css_class(:microcopy,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:section,
    padding_block: css_var({Tokens, :space, :"12"})
  )

  css_class(:section_header,
    display: "grid",
    gap: css_var({Tokens, :space, :"2"}),
    justify_items: "center",
    margin_bottom: css_var({Tokens, :space, :"8"}),
    text_align: "center"
  )

  css_class(:section_title,
    font_size: css_const({Tokens, :font_size, :"2xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:section_subtitle,
    max_width: "72ch",
    font_size: css_const({Tokens, :font_size, :lg}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fit, minmax(min(320px, 100%), 1fr))",
    gap: css_var({Tokens, :space, :"6"})
  )

  css_class(:card,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    padding: css_var({Tokens, :space, :"6"}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    transition: "transform 180ms ease, border-color 180ms ease",
    transform: [default: "translateY(0)", ":hover": "translateY(-2px)"],
    border_color: [
      default: css_var({Tokens, :semantic, :border_glass}),
      ":hover": css_var({Tokens, :semantic, :border_focus})
    ]
  )

  css_class(:card_kicker,
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_accent})
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    margin_top: css_var({Tokens, :space, :"2"}),
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_class(:card_text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:card_link,
    margin_top: css_var({Tokens, :space, :"4"}),
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_link}),
    text_decoration: [default: "none", ":hover": "underline"]
  )

  css_class(:browse_all,
    margin_top: css_var({Tokens, :space, :"8"}),
    text_align: "center"
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Home")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell active="home" show_footer>
      <section class={css_class([:hero])}>
        <div class={css_class([:hero_inner])}>
          <p class={css_class([:badge])}>
            <span aria-hidden="true">⚡</span>
            <span>Modern CSS for Phoenix LiveView—compiled</span>
          </p>

          <h1 class={css_class([:hero_title])}>
            Atomic CSS, <span class={css_class([:hero_gradient])}> without the class soup</span>.
          </h1>

          <p class={css_class([:hero_subtitle])}>
            LiveStyle is a next-generation CSS compiler built for Phoenix LiveView.
            Write styles in an Elixir-native way, compile to atomic CSS, keep HEEx readable,
            and use the full power of modern CSS (transitions, :has(), @property, and more).
          </p>

          <div class={css_class([:cta_row])}>
            <.link
              navigate={~p"/six-month-test"}
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
            >
              See the Six-Month Test
            </.link>
            <.link
              navigate={~p"/transitions"}
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
            >
              View Transitions
            </.link>
            <.link
              navigate={~p"/clean-heex"}
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
            >
              Clean HEEx
            </.link>
          </div>

          <p class={css_class([:microcopy])}>
            Open source · Atomic output · Tokens · All of CSS
          </p>
        </div>
      </section>

      <section class={css_class([:section])}>
        <header class={css_class([:section_header])}>
          <h2 class={css_class([:section_title])}>A holistic alternative to Tailwind ceilings</h2>
          <p class={css_class([:section_subtitle])}>
            Tailwind is great for prototypes. When you need deeper CSS—design tokens, refactors,
            and advanced browser APIs—LiveStyle keeps you moving without piling custom CSS on top.
          </p>
        </header>

        <div class={css_class([:grid])}>
          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>Templates</p>
            <h3 class={css_class([:card_title])}>Clean HEEx</h3>
            <p class={css_class([:card_text])}>
              Markup stays readable. Styles live in Elixir modules and compose cleanly—no utility
              explosions baked into every element.
            </p>
          </div>

          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>Design System</p>
            <h3 class={css_class([:card_title])}>Refactors Don’t Hurt</h3>
            <p class={css_class([:card_text])}>
              Change spacing scales and semantics in one place.
              Six months later, you update tokens—not thousands of templates.
            </p>
          </div>

          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>Power</p>
            <h3 class={css_class([:card_title])}>All of Modern CSS</h3>
            <p class={css_class([:card_text])}>
              View Transitions, :has(), @property, anchor positioning, container queries—if the
              browser can do it, LiveStyle can compile it.
            </p>
          </div>
        </div>
      </section>

      <section class={css_class([:section])}>
        <header class={css_class([:section_header])}>
          <h2 class={css_class([:section_title])}>Flagship demos</h2>
          <p class={css_class([:section_subtitle])}>
            A few quick pages that show why LiveStyle feels different.
          </p>
        </header>

        <div class={css_class([:grid])}>
          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>The Six-Month Test</p>
            <h3 class={css_class([:card_title])}>Change spacing with tokens</h3>
            <p class={css_class([:card_text])}>
              Flip between spacing scales and watch the UI reflow—without touching markup.
            </p>
            <.link navigate={~p"/six-month-test"} class={css_class([:card_link])}>
              Open demo <span aria-hidden="true">→</span>
            </.link>
          </div>

          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>Browser APIs</p>
            <h3 class={css_class([:card_title])}>View Transitions for LiveView</h3>
            <p class={css_class([:card_text])}>
              Make LiveView DOM updates feel native with shared-element style animations.
            </p>
            <.link navigate={~p"/transitions"} class={css_class([:card_link])}>
              Open demo <span aria-hidden="true">→</span>
            </.link>
          </div>

          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>Readability</p>
            <h3 class={css_class([:card_title])}>No utility soup</h3>
            <p class={css_class([:card_text])}>
              Compare typical utility markup against a LiveStyle component approach.
            </p>
            <.link navigate={~p"/clean-heex"} class={css_class([:card_link])}>
              Open demo <span aria-hidden="true">→</span>
            </.link>
          </div>

          <div class={css_class([:card])}>
            <p class={css_class([:card_kicker])}>Color System</p>
            <h3 class={css_class([:card_title])}>OKLCH + color-mix()</h3>
            <p class={css_class([:card_text])}>
              A practical, theme-aware way to generate gradients and tints.
            </p>
            <.link navigate={~p"/color"} class={css_class([:card_link])}>
              Open demo <span aria-hidden="true">→</span>
            </.link>
          </div>
        </div>

        <div class={css_class([:browse_all])}>
          <.link
            navigate={~p"/demos"}
            class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
          >
            Browse all demos
          </.link>
        </div>
      </section>
    </.shell>
    """
  end
end
