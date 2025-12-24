defmodule LiveStyleDemoWeb.ContainerLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Demo 1: Resizable Container
  # ============================================================================

  css_class(:resize_wrapper,
    display: "grid",
    grid_template_columns: "1fr 1fr",
    gap: css_var({Tokens, :space, :"6"}),
    margin_bottom: css_var({Tokens, :space, :"8"})
  )

  css_class(:resizable_container,
    resize: "horizontal",
    overflow: "auto",
    min_width: "200px",
    max_width: "100%",
    padding: css_var({Tokens, :space, :"4"}),
    border: "2px dashed",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    # Make it a container for queries
    container_type: "inline-size",
    container_name: "card-container"
  )

  css_class(:resize_hint,
    font_size: css_const({Tokens, :font_size, :xs}),
    color: css_var({Tokens, :semantic, :text_muted}),
    text_align: "center",
    margin_top: css_var({Tokens, :space, :"2"})
  )

  # Card that responds to container size
  css_class(:responsive_card,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  css_class(:card_inner,
    display: "flex",
    flex_direction: "column",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"})
  )

  # Use @container query to change layout at different sizes
  css_class(:card_inner_responsive,
    display: "flex",
    flex_direction: [default: "column", "@container card-container (min-width: 400px)": "row"],
    align_items: ["@container card-container (min-width: 400px)": "center"],
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"})
  )

  css_class(:card_image,
    width: [default: "100%", "@container card-container (min-width: 400px)": "120px"],
    height: "120px",
    background_color: css_var({Tokens, :semantic, :fill_secondary}),
    border_radius: css_const({Tokens, :radius, :md}),
    flex_shrink: "0"
  )

  css_class(:card_content,
    flex: "1"
  )

  css_class(:card_title,
    font_size: [
      default: css_const({Tokens, :font_size, :base}),
      "@container card-container (min-width: 400px)": css_const({Tokens, :font_size, :lg})
    ],
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"1"})
  )

  css_class(:card_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:card_badge,
    display: [default: "none", "@container card-container (min-width: 400px)": "inline-block"],
    padding: ["@container card-container (min-width: 400px)": "4px 8px"],
    background_color: [
      "@container card-container (min-width: 400px)":
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_primary})} 12%, #{css_var({Tokens, :semantic, :fill_muted})})"
    ],
    color: [
      "@container card-container (min-width: 400px)": css_var({Tokens, :semantic, :text_accent})
    ],
    font_size: [
      "@container card-container (min-width: 400px)": css_const({Tokens, :font_size, :xs})
    ],
    font_weight: [
      "@container card-container (min-width: 400px)": css_const({Tokens, :font_weight, :medium})
    ],
    border_radius: [
      "@container card-container (min-width: 400px)": css_const({Tokens, :radius, :full})
    ],
    margin_top: ["@container card-container (min-width: 400px)": css_var({Tokens, :space, :"2"})]
  )

  # ============================================================================
  # Demo 2: Sidebar Layout
  # ============================================================================

  css_class(:layout_demo,
    display: "grid",
    gap: css_var({Tokens, :space, :"4"}),
    grid_template_columns: "1fr",
    margin_bottom: css_var({Tokens, :space, :"8"})
  )

  css_class(:sidebar,
    container_type: "inline-size",
    container_name: "sidebar",
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    padding: css_var({Tokens, :space, :"4"})
  )

  css_class(:sidebar_nav,
    display: "flex",
    flex_direction: [default: "row", "@container sidebar (min-width: 200px)": "column"],
    flex_wrap: "wrap",
    gap: css_var({Tokens, :space, :"2"})
  )

  css_class(:sidebar_item,
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    cursor: "pointer",
    transition: "background-color 0.15s ease"
  )

  css_class(:sidebar_item_active,
    background_color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_primary})} 12%, #{css_var({Tokens, :semantic, :fill_muted})})",
    color: css_var({Tokens, :semantic, :text_accent}),
    font_weight: css_const({Tokens, :font_weight, :medium})
  )

  css_class(:main_content,
    container_type: "inline-size",
    container_name: "main",
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    padding: css_var({Tokens, :space, :"6"})
  )

  css_class(:content_grid,
    display: "grid",
    grid_template_columns: [
      default: "1fr",
      "@container main (min-width: 500px)": "1fr 1fr",
      "@container main (min-width: 700px)": "1fr 1fr 1fr"
    ],
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:content_card,
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border_radius: css_const({Tokens, :radius, :md}),
    padding: css_var({Tokens, :space, :"4"}),
    text_align: "center"
  )

  css_class(:content_card_number,
    font_size: css_const({Tokens, :font_size, :"2xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:content_card_label,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  # ============================================================================
  # Demo 3: Container Query Units
  # ============================================================================

  css_class(:cq_units_demo,
    container_type: "inline-size",
    container_name: "units-demo",
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    padding: css_var({Tokens, :space, :"6"}),
    resize: "horizontal",
    overflow: "auto",
    min_width: "250px"
  )

  css_class(:cq_title,
    # Font size scales with container width
    font_size: "clamp(1rem, 5cqi, 2.5rem)",
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:cq_box,
    # Width based on container
    width: "50cqi",
    height: "20cqi",
    background: css_var({Tokens, :semantic, :fill_primary}),
    border_radius: css_const({Tokens, :radius, :lg}),
    display: "flex",
    align_items: "center",
    justify_content: "center",
    color: css_var({Tokens, :semantic, :text_on_primary}),
    font_weight: css_const({Tokens, :font_weight, :medium})
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

        <div class={css_class([:resize_wrapper])}>
          <div>
            <div class={css_class([:resizable_container])}>
              <div class={css_class([:responsive_card])}>
                <div class={css_class([:card_inner_responsive])}>
                  <div class={css_class([:card_image])}></div>
                  <div class={css_class([:card_content])}>
                    <h3 class={css_class([:card_title])}>Adaptive Card</h3>
                    <p class={css_class([:card_text])}>
                      This card changes layout based on its container width, not the viewport.
                    </p>
                    <span class={css_class([:card_badge])}>Container-aware</span>
                  </div>
                </div>
              </div>
            </div>
            <p class={css_class([:resize_hint])}>← Drag to resize →</p>
          </div>

          <div>
            <div class={css_class([:resizable_container])}>
              <div class={css_class([:responsive_card])}>
                <div class={css_class([:card_inner_responsive])}>
                  <div class={css_class([:card_image])}></div>
                  <div class={css_class([:card_content])}>
                    <h3 class={css_class([:card_title])}>Another Card</h3>
                    <p class={css_class([:card_text])}>
                      Each container is independent - resize them separately!
                    </p>
                    <span class={css_class([:card_badge])}>Independent</span>
                  </div>
                </div>
              </div>
            </div>
            <p class={css_class([:resize_hint])}>← Drag to resize →</p>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Adaptive Grid</.demo_section_title>
        <.demo_section_description>
          The grid inside the main content area changes columns based on its own width using <.code_inline>@container main (min-width: ...)</.code_inline>.
        </.demo_section_description>

        <div class={css_class([:layout_demo])}>
          <div class={css_class([:sidebar])}>
            <nav class={css_class([:sidebar_nav])}>
              <div class={css_class([:sidebar_item, :sidebar_item_active])}>Dashboard</div>
              <div class={css_class([:sidebar_item])}>Analytics</div>
              <div class={css_class([:sidebar_item])}>Reports</div>
              <div class={css_class([:sidebar_item])}>Settings</div>
            </nav>
          </div>

          <div class={css_class([:main_content])}>
            <div class={css_class([:content_grid])}>
              <div :for={i <- 1..6} class={css_class([:content_card])}>
                <div class={css_class([:content_card_number])}>{i * 123}</div>
                <div class={css_class([:content_card_label])}>Metric {i}</div>
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

        <div class={css_class([:cq_units_demo])}>
          <h3 class={css_class([:cq_title])}>Fluid Typography</h3>
          <div class={css_class([:cq_box])}>50cqi × 20cqi</div>
        </div>
        <p class={css_class([:resize_hint])}>← Drag to resize →</p>
      </.demo_section>
    </.shell>
    """
  end
end
