defmodule LiveStyleDemoWeb.ContainerLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Page Layout
  # ============================================================================

  css_class(:page,
    min_height: "100vh",
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    font_family: css_const({Tokens, :font, :sans}),
    "-webkit-font-smoothing": "antialiased"
  )

  css_class(:header,
    padding: css_const({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border_bottom: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle})
  )

  css_class(:header_inner,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    display: "flex",
    align_items: "center",
    justify_content: "space-between"
  )

  css_class(:back_link,
    display: "inline-flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    text_decoration: "none"
  )

  css_class(:page_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:main,
    padding: css_const({Tokens, :space, :"8"})
  )

  css_class(:section,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    margin_bottom: css_const({Tokens, :space, :"12"})
  )

  css_class(:section_title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:section_description,
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    margin_bottom: css_const({Tokens, :space, :"6"}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:code_inline,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    padding: "2px 6px",
    border_radius: css_const({Tokens, :radius, :sm})
  )

  # ============================================================================
  # Demo 1: Resizable Container
  # ============================================================================

  css_class(:resize_wrapper,
    display: "grid",
    grid_template_columns: "1fr 1fr",
    gap: css_const({Tokens, :space, :"6"}),
    margin_bottom: css_const({Tokens, :space, :"8"})
  )

  css_class(:resizable_container,
    resize: "horizontal",
    overflow: "auto",
    min_width: "200px",
    max_width: "100%",
    padding: css_const({Tokens, :space, :"4"}),
    border: "2px dashed",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    # Make it a container for queries
    container_type: "inline-size",
    container_name: "card-container"
  )

  css_class(:resize_hint,
    font_size: css_const({Tokens, :font_size, :xs}),
    color: css_var({Tokens, :semantic, :text_muted}),
    text_align: "center",
    margin_top: css_const({Tokens, :space, :"2"})
  )

  # Card that responds to container size
  css_class(:responsive_card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    overflow: "hidden"
  )

  css_class(:card_inner,
    display: "flex",
    flex_direction: "column",
    gap: css_const({Tokens, :space, :"3"}),
    padding: css_const({Tokens, :space, :"4"})
  )

  # Use @container query to change layout at different sizes
  css_class(:card_inner_responsive,
    display: "flex",
    flex_direction: "column",
    gap: css_const({Tokens, :space, :"3"}),
    padding: css_const({Tokens, :space, :"4"}),
    "@container card-container (min-width: 400px)": %{
      flex_direction: "row",
      align_items: "center"
    }
  )

  css_class(:card_image,
    width: "100%",
    height: "120px",
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
    border_radius: css_const({Tokens, :radius, :md}),
    flex_shrink: "0",
    "@container card-container (min-width: 400px)": %{
      width: "120px",
      height: "120px"
    }
  )

  css_class(:card_content,
    flex: "1"
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :base}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"1"}),
    "@container card-container (min-width: 400px)": %{
      font_size: css_const({Tokens, :font_size, :lg})
    }
  )

  css_class(:card_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:card_badge,
    display: "none",
    "@container card-container (min-width: 400px)": %{
      display: "inline-block",
      padding: "4px 8px",
      background_color: css_var({Tokens, :colors, :indigo_100}),
      color: css_var({Tokens, :colors, :indigo_600}),
      font_size: css_const({Tokens, :font_size, :xs}),
      font_weight: css_const({Tokens, :font_weight, :medium}),
      border_radius: css_const({Tokens, :radius, :full}),
      margin_top: css_const({Tokens, :space, :"2"})
    }
  )

  # ============================================================================
  # Demo 2: Sidebar Layout
  # ============================================================================

  css_class(:layout_demo,
    display: "grid",
    gap: css_const({Tokens, :space, :"4"}),
    grid_template_columns: "1fr",
    margin_bottom: css_const({Tokens, :space, :"8"})
  )

  css_class(:sidebar,
    container_type: "inline-size",
    container_name: "sidebar",
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"4"})
  )

  css_class(:sidebar_nav,
    display: "flex",
    flex_direction: "row",
    flex_wrap: "wrap",
    gap: css_const({Tokens, :space, :"2"}),
    "@container sidebar (min-width: 200px)": %{
      flex_direction: "column"
    }
  )

  css_class(:sidebar_item,
    padding: "8px 12px",
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    cursor: "pointer",
    transition: "background-color 0.15s ease"
  )

  css_class(:sidebar_item_active,
    background_color: css_var({Tokens, :colors, :indigo_100}),
    color: css_var({Tokens, :colors, :indigo_600}),
    font_weight: css_const({Tokens, :font_weight, :medium})
  )

  css_class(:main_content,
    container_type: "inline-size",
    container_name: "main",
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"6"})
  )

  css_class(:content_grid,
    display: "grid",
    grid_template_columns: "1fr",
    gap: css_const({Tokens, :space, :"4"}),
    "@container main (min-width: 500px)": %{
      grid_template_columns: "1fr 1fr"
    },
    "@container main (min-width: 700px)": %{
      grid_template_columns: "1fr 1fr 1fr"
    }
  )

  css_class(:content_card,
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border_radius: css_const({Tokens, :radius, :md}),
    padding: css_const({Tokens, :space, :"4"}),
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
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"6"}),
    resize: "horizontal",
    overflow: "auto",
    min_width: "250px"
  )

  css_class(:cq_title,
    # Font size scales with container width
    font_size: "clamp(1rem, 5cqi, 2.5rem)",
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  css_class(:cq_box,
    # Width based on container
    width: "50cqi",
    height: "20cqi",
    background: "linear-gradient(135deg, #10b981, #059669)",
    border_radius: css_const({Tokens, :radius, :lg}),
    display: "flex",
    align_items: "center",
    justify_content: "center",
    color: css_var({Tokens, :colors, :white}),
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
    <div class={css_class([:page])}>
      <header class={css_class([:header])}>
        <div class={css_class([:header_inner])}>
          <.link navigate="/" class={css_class([:back_link])}>
            ← Back to Home
          </.link>
          <h1 class={css_class([:page_title])}>Container Queries</h1>
          <div></div>
        </div>
      </header>

      <main class={css_class([:main])}>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Responsive Card</h2>
          <p class={css_class([:section_description])}>
            Drag the resize handle to change the container width. The card layout adapts based on
            <code class={css_class([:code_inline])}>@container</code>
            queries, not viewport size.
          </p>

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
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Adaptive Grid</h2>
          <p class={css_class([:section_description])}>
            The grid inside the main content area changes columns based on its own width using <code class={
              css_class([:code_inline])
            }>@container main (min-width: ...)</code>.
          </p>

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
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Container Query Units</h2>
          <p class={css_class([:section_description])}>
            Use <code class={css_class([:code_inline])}>cqi</code>
            (container query inline) units to size
            elements relative to their container. Resize to see the text and box scale.
          </p>

          <div class={css_class([:cq_units_demo])}>
            <h3 class={css_class([:cq_title])}>Fluid Typography</h3>
            <div class={css_class([:cq_box])}>50cqi × 20cqi</div>
          </div>
          <p class={css_class([:resize_hint])}>← Drag to resize →</p>
        </section>
      </main>
    </div>
    """
  end
end
