defmodule LiveStyleDemoWeb.HomeLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:hero,
    padding_block: var({Space, :"16"}),
    text_align: "center"
  )

  class(:hero_inner,
    max_width: "70rem",
    margin_inline: "auto",
    display: "grid",
    gap: var({Space, :"6"}),
    justify_items: "center"
  )

  class(:hero_title,
    font_size: "clamp(2.5rem, 2rem + 3vw, 5rem)",
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.04em",
    line_height: const({Tokens, :leading_none}),
    color: var({Semantic, :text_primary})
  )

  class(:hero_highlight,
    color: var({Semantic, :text_accent}),
    text_decoration: "underline",
    text_decoration_thickness: "4px",
    text_underline_offset: "4px"
  )

  class(:hero_subtitle,
    max_width: "65ch",
    margin_inline: "auto",
    font_size: const({Tokens, :font_size_xl}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:cta_row,
    display: "flex",
    flex_wrap: "wrap",
    justify_content: "center",
    gap: var({Space, :"3"})
  )

  class(:microcopy,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_muted})
  )

  class(:section,
    padding_block: var({Space, :"6"})
  )

  class(:section_header,
    display: "grid",
    gap: var({Space, :"2"}),
    justify_items: "center",
    margin_bottom: var({Space, :"8"}),
    text_align: "center"
  )

  class(:section_title,
    font_size: const({Tokens, :font_size_2xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    line_height: const({Tokens, :leading_tight})
  )

  class(:section_subtitle,
    max_width: "72ch",
    font_size: const({Tokens, :font_size_lg}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fit, minmax(min(340px, 100%), 1fr))",
    gap: var({Space, :"6"})
  )

  class(:card_inner,
    display: "flex",
    flex_direction: "column",
    gap: var({Space, :"4"}),
    height: "100%",
    padding: var({Space, :"6"})
  )

  class(:card_kicker,
    font_size: const({Tokens, :font_size_xs}),
    font_weight: const({Tokens, :font_weight_bold}),
    text_transform: "uppercase",
    letter_spacing: "0.05em",
    color: var({Semantic, :text_accent}),
    margin_bottom: var({Space, :"1"})
  )

  class(:card_title,
    font_size: const({Tokens, :font_size_2xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.03em",
    line_height: const({Tokens, :leading_tight}),
    margin: "0"
  )

  class(:card_text,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed}),
    font_size: const({Tokens, :font_size_lg})
  )

  class(:card_footer,
    margin_top: "auto",
    padding_top: var({Space, :"4"})
  )

  class(:card_link,
    margin_top: var({Space, :"4"}),
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    font_weight: const({Tokens, :font_weight_medium}),
    color: var({Semantic, :text_link}),
    text_decoration: [default: "none", ":hover": "underline"]
  )

  class(:browse_all,
    margin_top: var({Space, :"8"}),
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
      <section {css(:hero)}>
        <div {css(:hero_inner)}>
          <.badge>
            <span aria-hidden="true">⚡</span>
            <span>Zero-Runtime CSS for Phoenix</span>
          </.badge>

          <h1 {css(:hero_title)}>
            <span {css(:hero_highlight)}>One Codebase.</span> Any Theme.
          </h1>

          <p {css(:hero_subtitle)}>
            Stop fighting class string soup. LiveStyle brings the power of design tokens
            and type-safe CSS directly into your LiveViews.
            Compile-time styling, zero runtime overhead, and radical design flexibility.
          </p>

          <div {css(:cta_row)}>
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

          <p {css(:microcopy)}>
            Open source · Atomic output · Type-safe · All of CSS
          </p>
        </div>
      </section>

      <section {css(:section)}>
        <header {css(:section_header)}>
          <h2 {css(:section_title)}>Breaking the Tailwind Ceiling</h2>
          <p {css(:section_subtitle)}>
            Tailwind is amazing, but large apps hit a wall. LiveStyle gives you the
            composability of utility classes with the maintainability of a design system.
          </p>
        </header>

        <div {css(:grid)}>
          <.card>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Theming</p>
                <h3 {css(:card_title)}>Strict Theme Constraints</h3>
              </div>
              <p {css(:card_text)}>
                This demo enforces strict constraints (max 3 colors per theme) to prove the system's flexibility.
                8+ themes, one markup structure.
              </p>
            </div>
          </.card>

          <.card>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Design System</p>
                <h3 {css(:card_title)}>Tokens > Classes</h3>
              </div>
              <p {css(:card_text)}>
                Change spacing scales and color semantics in one place.
                The markup never mentions "text-red-500" or "p-4"—only semantic tokens.
              </p>
            </div>
          </.card>

          <.card>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Power</p>
                <h3 {css(:card_title)}>Modern CSS</h3>
              </div>
              <p {css(:card_text)}>
                View Transitions, :has(), @container, and scroll-driven animations.
                LiveStyle compiles it all to standard CSS files.
              </p>
            </div>
          </.card>
        </div>
      </section>

      <section {css(:section)}>
        <header {css(:section_header)}>
          <h2 {css(:section_title)}>Flagship Demos</h2>
          <p {css(:section_subtitle)}>
            See why LiveStyle feels different.
          </p>
        </header>

        <div {css(:grid)}>
          <.card interactive>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Theming</p>
                <h3 {css(:card_title)}>Change spacing with tokens</h3>
              </div>
              <p {css(:card_text)}>
                Flip between spacing scales and watch the UI reflow—without touching markup.
              </p>
              <div {css(:card_footer)}>
                <.button variant={:secondary} navigate={~p"/theming"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>

          <.card interactive>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Browser APIs</p>
                <h3 {css(:card_title)}>View Transitions</h3>
              </div>
              <p {css(:card_text)}>
                Make LiveView DOM updates feel native with shared-element style animations.
              </p>
              <div {css(:card_footer)}>
                <.button variant={:secondary} navigate={~p"/transitions"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>

          <.card interactive>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Components</p>
                <h3 {css(:card_title)}>No utility soup</h3>
              </div>
              <p {css(:card_text)}>
                Compare typical utility markup against a LiveStyle component approach.
              </p>
              <div {css(:card_footer)}>
                <.button variant={:secondary} navigate={~p"/components"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>

          <.card interactive>
            <div {css(:card_inner)}>
              <div>
                <p {css(:card_kicker)}>Interactive</p>
                <h3 {css(:card_title)}>Focus Card</h3>
              </div>
              <p {css(:card_text)}>
                A highly interactive card using only solid colors, borders, and transforms.
              </p>
              <div {css(:card_footer)}>
                <.button variant={:secondary} navigate={~p"/focus-card"}>
                  Open demo <span aria-hidden="true">→</span>
                </.button>
              </div>
            </div>
          </.card>
        </div>

        <div {css(:browse_all)}>
          <.button variant={:secondary} navigate={~p"/demos"}>
            Browse all demos
          </.button>
        </div>
      </section>
    </.shell>
    """
  end
end
