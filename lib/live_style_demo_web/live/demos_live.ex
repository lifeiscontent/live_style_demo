defmodule LiveStyleDemoWeb.DemosLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:stack,
    display: "grid",
    gap: var({Space, :"10"})
  )

  class(:section,
    display: "grid",
    gap: var({Space, :"4"})
  )

  class(:section_header,
    display: "grid",
    gap: var({Space, :"1"})
  )

  class(:section_title,
    font_size: const({Tokens, :font_size_xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    line_height: const({Tokens, :leading_tight})
  )

  class(:section_text,
    max_width: "80ch",
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:grid,
    display: "grid",
    gap: var({Space, :"6"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(280px, 100%), 1fr))"
  )

  class(:title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    line_height: const({Tokens, :leading_tight}),
    color: var({Semantic, :text_primary})
  )

  class(:text,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed}),
    font_size: const({Tokens, :font_size_base})
  )

  class(:link_area,
    margin_top: "auto",
    padding_top: var({Space, :"4"})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Demos")}
  end

  defp demo_card(assigns) do
    ~H"""
    <.card as={:section} interactive>
      <div>
        <h3 {css(:title)}>{@title}</h3>
      </div>
      <p :if={@text} {css(:text)}>{@text}</p>
      <div {css(:link_area)}>
        <.button variant={:secondary} navigate={@to}>
          Open →
        </.button>
      </div>
    </.card>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="demos"
      show_footer
      page_title="Demos"
      page_subtitle="A curated set of modern CSS capabilities—compiled for Phoenix LiveView."
    >
      <div {css(:stack)}>
        <section {css(:section)}>
          <header {css(:section_header)}>
            <h2 {css(:section_title)}>Flagships</h2>
            <p {css(:section_text)}>
              The "Ah-ha" moments. Clean templates, zero-runtime tokens, and APIs that usually require JS libraries.
            </p>
          </header>

          <div {css(:grid)}>
            <.demo_card
              title="Theming"
              text="Swap spacing scales and colors instantly with zero runtime overhead."
              to={~p"/theming"}
            />
            <.demo_card
              title="Components"
              text="Atomic output without turning templates into class strings."
              to={~p"/components"}
            />
            <.demo_card
              title="View Transitions"
              text="Native-feeling page transitions with pure CSS."
              to={~p"/transitions"}
            />
            <.demo_card
              title="CSS Anchor Positioning"
              text="Tooltips and floating elements without JavaScript."
              to={~p"/anchor"}
            />
            <.demo_card
              title="Color & OKLCH"
              text="Dynamic color palettes with type-safe custom properties."
              to={~p"/color"}
            />
          </div>
        </section>

        <section {css(:section)}>
          <header {css(:section_header)}>
            <h2 {css(:section_title)}>Selectors & UI APIs</h2>
            <p {css(:section_text)}>
              Things you usually install a library for. Handled natively in CSS.
            </p>
          </header>

          <div {css(:grid)}>
            <.demo_card
              title="Parent Selector :has()"
              text="Style parents based on children. No more state lifting for simple UI."
              to={~p"/parent-selector"}
            />
            <.demo_card
              title="Popover API"
              text="Native modals, menus, and toasts. No z-index wars."
              to={~p"/popover"}
            />
          </div>
        </section>

        <section {css(:section)}>
          <header {css(:section_header)}>
            <h2 {css(:section_title)}>Responsive & Motion</h2>
            <p {css(:section_text)}>
              Responsive components and scroll-linked animations—no JS frameworks required.
            </p>
          </header>

          <div {css(:grid)}>
            <.demo_card
              title="Container Queries"
              text="Components that adapt to their container, not the viewport."
              to={~p"/container"}
            />
            <.demo_card
              title="Scroll-Driven Animations"
              text="Animate based on scroll position using standard CSS."
              to={~p"/scroll"}
            />
            <.demo_card
              title="@starting-style"
              text="Enter animations for elements added to the DOM."
              to={~p"/starting-style"}
            />
          </div>
        </section>

        <section {css(:section)}>
          <header {css(:section_header)}>
            <h2 {css(:section_title)}>Visual Systems</h2>
            <p {css(:section_text)}>
              Tokens + color science + effects.
            </p>
          </header>

          <div {css(:grid)}>
            <.demo_card
              title="Focus Card"
              text="High-fidelity interactivity with zero JavaScript."
              to={~p"/focus-card"}
            />
          </div>
        </section>

        <section {css(:section)}>
          <header {css(:section_header)}>
            <h2 {css(:section_title)}>App & Components</h2>
            <p {css(:section_text)}>
              Traditional UI patterns—plus a small LiveView app showing how these pieces combine.
            </p>
          </header>

          <div {css(:grid)}>
            <.demo_card
              title="Todo App"
              text="A fully functional app showcasing transitions and state."
              to={~p"/todo"}
            />
            <.demo_card
              title="Price Table"
              text="Complex layouts made simple with modern CSS grid and :has()."
              to={~p"/table"}
            />
          </div>
        </section>
      </div>
    </.shell>
    """
  end
end
