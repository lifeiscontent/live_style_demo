defmodule LiveStyleDemoWeb.ContainerLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  # ============================================================================
  # Demo 1: Resizable Container
  # ============================================================================

  class(:resize_wrapper,
    display: "grid",
    grid_template_columns: "1fr 1fr",
    gap: var({Space, :"6"}),
    margin_bottom: var({Space, :"8"})
  )

  class(:resizable_container,
    resize: "horizontal",
    overflow: "auto",
    min_width: "200px",
    max_width: "100%",
    padding: var({Space, :"4"}),
    border: "2px dashed",
    border_color: var({Semantic, :border_subtle}),
    border_radius: const({Tokens, :radius_2xl}),
    # Make it a container for queries
    container_type: "inline-size",
    container_name: "card-container"
  )

  class(:resize_hint,
    font_size: const({Tokens, :font_size_xs}),
    color: var({Semantic, :text_muted}),
    text_align: "center",
    margin_top: var({Space, :"2"})
  )

  # Card that responds to container size
  class(:responsive_card,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_lg}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  class(:card_inner,
    display: "flex",
    flex_direction: "column",
    gap: var({Space, :"3"}),
    padding: var({Space, :"4"})
  )

  # Use @container query to change layout at different sizes
  class(:card_inner_responsive,
    display: "flex",
    flex_direction: [default: "column", "@container card-container (min-width: 400px)": "row"],
    align_items: ["@container card-container (min-width: 400px)": "center"],
    gap: var({Space, :"3"}),
    padding: var({Space, :"4"})
  )

  class(:card_image,
    width: [default: "100%", "@container card-container (min-width: 400px)": "120px"],
    height: "120px",
    background_color: var({Semantic, :fill_secondary}),
    border_radius: const({Tokens, :radius_md}),
    flex_shrink: "0"
  )

  class(:card_content,
    flex: "1"
  )

  class(:card_title,
    font_size: [
      default: const({Tokens, :font_size_base}),
      "@container card-container (min-width: 400px)": const({Tokens, :font_size_lg})
    ],
    font_weight: const({Tokens, :font_weight_semibold}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"1"})
  )

  class(:card_text,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:card_badge,
    display: [default: "none", "@container card-container (min-width: 400px)": "inline-block"],
    padding: ["@container card-container (min-width: 400px)": "4px 8px"],
    background_color: [
      "@container card-container (min-width: 400px)":
        "color-mix(in oklab, #{var({Semantic, :fill_primary})} 12%, #{var({Semantic, :fill_muted})})"
    ],
    color: [
      "@container card-container (min-width: 400px)": var({Semantic, :text_accent})
    ],
    font_size: [
      "@container card-container (min-width: 400px)": const({Tokens, :font_size_xs})
    ],
    font_weight: [
      "@container card-container (min-width: 400px)": const({Tokens, :font_weight_medium})
    ],
    border_radius: [
      "@container card-container (min-width: 400px)": const({Tokens, :radius_full})
    ],
    margin_top: ["@container card-container (min-width: 400px)": var({Space, :"2"})]
  )

  # ============================================================================
  # Demo 2: Sidebar Layout
  # ============================================================================

  class(:layout_demo,
    display: "grid",
    gap: var({Space, :"4"}),
    grid_template_columns: "1fr",
    margin_bottom: var({Space, :"8"})
  )

  class(:sidebar,
    container_type: "inline-size",
    container_name: "sidebar",
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    padding: var({Space, :"4"})
  )

  class(:sidebar_nav,
    display: "flex",
    flex_direction: [default: "row", "@container sidebar (min-width: 200px)": "column"],
    flex_wrap: "wrap",
    gap: var({Space, :"2"})
  )

  class(:sidebar_item,
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    border_radius: const({Tokens, :radius_md}),
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    cursor: "pointer",
    transition: "background-color 0.15s ease"
  )

  class(:sidebar_item_active,
    background_color:
      "color-mix(in oklab, #{var({Semantic, :fill_primary})} 12%, #{var({Semantic, :fill_muted})})",
    color: var({Semantic, :text_accent}),
    font_weight: const({Tokens, :font_weight_medium})
  )

  class(:main_content,
    container_type: "inline-size",
    container_name: "main",
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    padding: var({Space, :"6"})
  )

  class(:content_grid,
    display: "grid",
    grid_template_columns: [
      default: "1fr",
      "@container main (min-width: 500px)": "1fr 1fr",
      "@container main (min-width: 700px)": "1fr 1fr 1fr"
    ],
    gap: var({Space, :"4"})
  )

  class(:content_card,
    background_color: var({Semantic, :fill_muted}),
    border_radius: const({Tokens, :radius_md}),
    padding: var({Space, :"4"}),
    text_align: "center"
  )

  class(:content_card_number,
    font_size: const({Tokens, :font_size_2xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    color: var({Semantic, :text_primary})
  )

  class(:content_card_label,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary})
  )

  # ============================================================================
  # Demo 3: Container Query Units
  # ============================================================================

  class(:cq_units_demo,
    container_type: "inline-size",
    container_name: "units-demo",
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    padding: var({Space, :"6"}),
    resize: "horizontal",
    overflow: "auto",
    min_width: "250px"
  )

  class(:cq_title,
    # Font size scales with container width
    font_size: "clamp(1rem, 5cqi, 2.5rem)",
    font_weight: const({Tokens, :font_weight_bold}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"4"})
  )

  class(:cq_box,
    # Width based on container
    width: "50cqi",
    height: "20cqi",
    background: var({Semantic, :fill_primary}),
    border_radius: const({Tokens, :radius_lg}),
    display: "flex",
    align_items: "center",
    justify_content: "center",
    color: var({Semantic, :text_on_primary}),
    font_weight: const({Tokens, :font_weight_medium})
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Container Queries")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="container"
      page_title="Container Queries"
      page_subtitle="Responsive components that react to their own container."
    >
      <.demo_section>
        <.demo_section_title>Responsive Card</.demo_section_title>
        <.demo_section_description>
          Drag the resize handle to change the container width. The card layout adapts based on
          <.code_inline>@container</.code_inline>
          queries, not viewport size.
        </.demo_section_description>

        <div {css(:resize_wrapper)}>
          <div>
            <div {css(:resizable_container)}>
              <div {css(:responsive_card)}>
                <div {css(:card_inner_responsive)}>
                  <div {css(:card_image)}></div>
                  <div {css(:card_content)}>
                    <h3 {css(:card_title)}>Adaptive Card</h3>
                    <p {css(:card_text)}>
                      This card changes layout based on its container width, not the viewport.
                    </p>
                    <span {css(:card_badge)}>Container-aware</span>
                  </div>
                </div>
              </div>
            </div>
            <p {css(:resize_hint)}>← Drag to resize →</p>
          </div>

          <div>
            <div {css(:resizable_container)}>
              <div {css(:responsive_card)}>
                <div {css(:card_inner_responsive)}>
                  <div {css(:card_image)}></div>
                  <div {css(:card_content)}>
                    <h3 {css(:card_title)}>Another Card</h3>
                    <p {css(:card_text)}>
                      Each container is independent - resize them separately!
                    </p>
                    <span {css(:card_badge)}>Independent</span>
                  </div>
                </div>
              </div>
            </div>
            <p {css(:resize_hint)}>← Drag to resize →</p>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Adaptive Grid</.demo_section_title>
        <.demo_section_description>
          The grid inside the main content area changes columns based on its own width using <.code_inline>@container main (min-width: ...)</.code_inline>.
        </.demo_section_description>

        <div {css(:layout_demo)}>
          <div {css(:sidebar)}>
            <nav {css(:sidebar_nav)}>
              <div {css([:sidebar_item, :sidebar_item_active])}>Dashboard</div>
              <div {css(:sidebar_item)}>Analytics</div>
              <div {css(:sidebar_item)}>Reports</div>
              <div {css(:sidebar_item)}>Settings</div>
            </nav>
          </div>

          <div {css(:main_content)}>
            <div {css(:content_grid)}>
              <div :for={i <- 1..6} {css(:content_card)}>
                <div {css(:content_card_number)}>{i * 123}</div>
                <div {css(:content_card_label)}>Metric {i}</div>
              </div>
            </div>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Container Query Units</.demo_section_title>
        <.demo_section_description>
          Use
          <.code_inline>cqi</.code_inline>
          (container query inline) units to size
          elements relative to their container. Resize to see the text and box scale.
        </.demo_section_description>

        <div {css(:cq_units_demo)}>
          <h3 {css(:cq_title)}>Fluid Typography</h3>
          <div {css(:cq_box)}>50cqi × 20cqi</div>
        </div>
        <p {css(:resize_hint)}>← Drag to resize →</p>
      </.demo_section>
    </.shell>
    """
  end
end
