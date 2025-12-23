defmodule LiveStyleDemoWeb.DemosLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens

  css_class(:stack,
    display: "grid",
    gap: css_var({Tokens, :space, :"10"})
  )

  css_class(:section,
    display: "grid",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:section_header,
    display: "grid",
    gap: css_var({Tokens, :space, :"1"})
  )

  css_class(:section_title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:section_text,
    max_width: "80ch",
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:grid,
    display: "grid",
    gap: css_var({Tokens, :space, :"6"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(280px, 100%), 1fr))"
  )

  css_class(:title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    line_height: css_const({Tokens, :leading, :tight}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    font_size: css_const({Tokens, :font_size, :base})
  )

  css_class(:link_area,
    margin_top: "auto",
    padding_top: css_var({Tokens, :space, :"4"})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Demos")}
  end

  defp demo_card(assigns) do
    ~H"""
    <section class={css_class([{BaseStyles, :card_interactive}])}>
      <div>
        <h3 class={css_class([:title])}>{@title}</h3>
      </div>
      <p :if={@text} class={css_class([:text])}>{@text}</p>
      <div class={css_class([:link_area])}>
        <.link navigate={@to} class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}>
          Open →
        </.link>
      </div>
    </section>
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
      <div class={css_class([:stack])}>
        <section class={css_class([:section])}>
          <header class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Flagships</h2>
            <p class={css_class([:section_text])}>
              The "Ah-ha" moments. Clean templates, zero-runtime tokens, and APIs that usually require JS libraries.
            </p>
          </header>

          <div class={css_class([:grid])}>
            <.demo_card
              title="Theming"
              text="Swap spacing scales with tokens—not template refactors."
              to={~p"/theming"}
            />
            <.demo_card
              title="Components"
              text="Atomic output without turning templates into class strings."
              to={~p"/components"}
            />
            <.demo_card
              title="View Transitions Lab"
              text="Smooth DOM animations for shuffles, inserts, and deletes."
              to={~p"/transitions"}
            />
            <.demo_card
              title="CSS Anchor Positioning"
              text="Anchor tooltips + smart fallbacks with pure CSS."
              to={~p"/anchor"}
            />
            <.demo_card
              title="Color & OKLCH"
              text="OKLCH + color-mix() + typed custom properties (@property)."
              to={~p"/color"}
            />
          </div>
        </section>

        <section class={css_class([:section])}>
          <header class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Selectors & UI APIs</h2>
            <p class={css_class([:section_text])}>
              Things you usually install a library for. Handled natively in CSS.
            </p>
          </header>

          <div class={css_class([:grid])}>
            <.demo_card
              title="CSS Anchor Positioning"
              text="Anchor tooltips + smart fallbacks with pure CSS."
              to={~p"/anchor"}
            />
            <.demo_card
              title=":has()"
              text="The parent selector: conditional styling based on descendants."
              to={~p"/parent-selector"}
            />
            <.demo_card
              title="Popover API"
              text="Native popovers: modals, menus, toasts."
              to={~p"/popover"}
            />
          </div>
        </section>

        <section class={css_class([:section])}>
          <header class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Responsive & Motion</h2>
            <p class={css_class([:section_text])}>
              Responsive components and scroll-linked animations—no JS frameworks required.
            </p>
          </header>

          <div class={css_class([:grid])}>
            <.demo_card
              title="Container Queries"
              text="Responsive components that react to their own container."
              to={~p"/container"}
            />
            <.demo_card
              title="Scroll-Driven Animations"
              text="scroll() + view() timelines, animation-range, pure CSS motion."
              to={~p"/scroll"}
            />
            <.demo_card
              title="@starting-style"
              text="First-render transitions, no JS required."
              to={~p"/starting-style"}
            />
          </div>
        </section>

        <section class={css_class([:section])}>
          <header class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Visual Systems</h2>
            <p class={css_class([:section_text])}>
              Tokens + color science + effects.
            </p>
          </header>

          <div class={css_class([:grid])}>
            <.demo_card
              title="Color & OKLCH"
              text="OKLCH + color-mix() + typed custom properties (@property)."
              to={~p"/color"}
            />
            <.demo_card
              title="Focus Card"
              text="A highly interactive card using only solid colors, borders, and transforms."
              to={~p"/focus-card"}
            />
          </div>
        </section>

        <section class={css_class([:section])}>
          <header class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>App & Components</h2>
            <p class={css_class([:section_text])}>
              Traditional UI patterns—plus a small LiveView app showing how these pieces combine.
            </p>
          </header>

          <div class={css_class([:grid])}>
            <.demo_card
              title="Todo App"
              text="A small LiveView app using transitions + tiny JS hooks."
              to={~p"/todo"}
            />
            <.demo_card
              title="Price Table"
              text="Real-world :has() cross-highlighting in a dense layout."
              to={~p"/table"}
            />
          </div>
        </section>
      </div>
    </.shell>
    """
  end
end
