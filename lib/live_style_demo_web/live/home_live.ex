defmodule LiveStyleDemoWeb.HomeLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

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

  css_class(:hero_title,
    font_size: "clamp(2.5rem, 2rem + 3vw, 5rem)",
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.04em",
    line_height: css_const({Tokens, :leading, :none}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:hero_highlight,
    color: css_var({Tokens, :semantic, :text_accent}),
    text_decoration: "underline",
    text_decoration_thickness: "4px",
    text_underline_offset: "4px"
  )

  css_class(:hero_subtitle,
    max_width: "65ch",
    margin_inline: "auto",
    font_size: css_const({Tokens, :font_size, :xl}),
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
    padding_block: css_var({Tokens, :space, :"6"})
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
    grid_template_columns: "repeat(auto-fit, minmax(min(340px, 100%), 1fr))",
    gap: css_var({Tokens, :space, :"6"})
  )

  css_class(:card_inner,
    display: "flex",
    flex_direction: "column",
    gap: css_var({Tokens, :space, :"4"}),
    height: "100%",
    padding: css_var({Tokens, :space, :"6"})
  )

  css_class(:card_kicker,
    font_size: css_const({Tokens, :font_size, :xs}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    text_transform: "uppercase",
    letter_spacing: "0.05em",
    color: css_var({Tokens, :semantic, :text_accent}),
    margin_bottom: css_var({Tokens, :space, :"1"})
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :"2xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.03em",
    line_height: css_const({Tokens, :leading, :tight}),
    margin: "0"
  )

  css_class(:card_text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    font_size: css_const({Tokens, :font_size, :lg})
  )

  css_class(:card_footer,
    margin_top: "auto",
    padding_top: css_var({Tokens, :space, :"4"})
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
          <.badge>
            <span aria-hidden="true">⚡</span>
            <span>Zero-Runtime CSS for Phoenix</span>
          </.badge>

          <h1 class={css_class([:hero_title])}>
            <span class={css_class([:hero_highlight])}>One Codebase.</span> Any Theme.
          </h1>

          <p class={css_class([:hero_subtitle])}>
            Stop fighting class string soup. LiveStyle brings the power of design tokens
            and type-safe CSS directly into your LiveViews.
            Compile-time styling, zero runtime overhead, and radical design flexibility.
          </p>

          <div class={css_class([:cta_row])}>
            <.button variant={:primary} navigate={~p"/theming"}>
              See Theming
            </.button>
            <.button variant={:secondary} navigate={~p"/transitions"}>
              View Transitions
            </.button>
            <.button variant={:secondary} navigate={~p"/components"}>
              Components
            </.button>
          </div>

          <p class={css_class([:microcopy])}>
            Open source · Atomic output · Type-safe · All of CSS
          </p>
        </div>
      </section>

      <section class={css_class([:section])}>
        <header class={css_class([:section_header])}>
          <h2 class={css_class([:section_title])}>Breaking the Tailwind Ceiling</h2>
          <p class={css_class([:section_subtitle])}>
            Tailwind is amazing, but large apps hit a wall. LiveStyle gives you the
            composability of utility classes with the maintainability of a design system.
          </p>
        </header>

        <div class={css_class([:grid])}>
          <.card>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Theming</p>
                <h3 class={css_class([:card_title])}>Strict Theme Constraints</h3>
              </div>
              <p class={css_class([:card_text])}>
                This demo enforces strict constraints (max 3 colors per theme) to prove the system's flexibility.
                8+ themes, one markup structure.
              </p>
            </div>
          </.card>

          <.card>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Design System</p>
                <h3 class={css_class([:card_title])}>Tokens > Classes</h3>
              </div>
              <p class={css_class([:card_text])}>
                Change spacing scales and color semantics in one place.
                The markup never mentions "text-red-500" or "p-4"—only semantic tokens.
              </p>
            </div>
          </.card>

          <.card>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Power</p>
                <h3 class={css_class([:card_title])}>Modern CSS</h3>
              </div>
              <p class={css_class([:card_text])}>
                View Transitions, :has(), @container, and scroll-driven animations.
                LiveStyle compiles it all to standard CSS files.
              </p>
            </div>
          </.card>
        </div>
      </section>

      <section class={css_class([:section])}>
        <header class={css_class([:section_header])}>
          <h2 class={css_class([:section_title])}>Flagship Demos</h2>
          <p class={css_class([:section_subtitle])}>
            See why LiveStyle feels different.
          </p>
        </header>

        <div class={css_class([:grid])}>
          <.card interactive>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Theming</p>
                <h3 class={css_class([:card_title])}>Change spacing with tokens</h3>
              </div>
              <p class={css_class([:card_text])}>
                Flip between spacing scales and watch the UI reflow—without touching markup.
              </p>
              <div class={css_class([:card_footer])}>
                <.button variant={:secondary} navigate={~p"/theming"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>

          <.card interactive>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Browser APIs</p>
                <h3 class={css_class([:card_title])}>View Transitions</h3>
              </div>
              <p class={css_class([:card_text])}>
                Make LiveView DOM updates feel native with shared-element style animations.
              </p>
              <div class={css_class([:card_footer])}>
                <.button variant={:secondary} navigate={~p"/transitions"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>

          <.card interactive>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Components</p>
                <h3 class={css_class([:card_title])}>No utility soup</h3>
              </div>
              <p class={css_class([:card_text])}>
                Compare typical utility markup against a LiveStyle component approach.
              </p>
              <div class={css_class([:card_footer])}>
                <.button variant={:secondary} navigate={~p"/components"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>

          <.card interactive>
            <div class={css_class([:card_inner])}>
              <div>
                <p class={css_class([:card_kicker])}>Interactive</p>
                <h3 class={css_class([:card_title])}>Focus Card</h3>
              </div>
              <p class={css_class([:card_text])}>
                A highly interactive card using only solid colors, borders, and transforms.
              </p>
              <div class={css_class([:card_footer])}>
                <.button variant={:secondary} navigate={~p"/focus-card"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>
        </div>

        <div class={css_class([:browse_all])}>
          <.button variant={:secondary} navigate={~p"/demos"}>
            Browse all demos
          </.button>
        </div>
      </section>
    </.shell>
    """
  end
end
