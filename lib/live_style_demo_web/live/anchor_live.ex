defmodule LiveStyleDemoWeb.AnchorLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyle.Marker
  alias LiveStyle.When

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.BaseStyles

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
    text_decoration: "none",
    transition: "color 0.2s ease"
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

  css_class(:demo_container,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px dashed",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"8"}),
    min_height: "300px",
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  css_class(:code_inline,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    padding: "2px 6px",
    border_radius: css_const({Tokens, :radius, :sm})
  )

  css_class(:browser_note,
    display: "inline-flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    margin_top: css_const({Tokens, :space, :"4"}),
    padding: "8px 12px",
    background_color: css_var({Tokens, :colors, :amber_50}),
    color: css_var({Tokens, :colors, :amber_600}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md})
  )

  # ============================================================================
  # Demo 1: Basic Tooltip with Anchor Positioning
  # ============================================================================

  css_class(:basic_anchor,
    anchor_name: "--basic-anchor"
  )

  css_class(:basic_tooltip,
    position: "fixed",
    position_anchor: "--basic-anchor",
    position_area: "bottom center",
    margin_top: "8px",
    position_try_fallbacks: "flip-block, flip-inline",
    # Hidden by default
    opacity: %{
      :default => "0",
      When.sibling_before(":hover") => "1",
      When.sibling_before(":focus") => "1"
    },
    visibility: %{
      :default => "hidden",
      When.sibling_before(":hover") => "visible",
      When.sibling_before(":focus") => "visible"
    },
    pointer_events: "none",
    transition: "opacity 0.15s ease",
    # Styling
    white_space: "nowrap",
    padding: "8px 12px",
    background_color: css_var({Tokens, :colors, :gray_900}),
    color: css_var({Tokens, :colors, :white}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    z_index: "1000"
  )

  # ============================================================================
  # Demo 2: Grid of Anchored Elements
  # ============================================================================

  css_class(:grid_demo,
    display: "grid",
    grid_template_columns: "1fr 1fr 1fr",
    grid_template_rows: "1fr 1fr 1fr",
    gap: css_const({Tokens, :space, :"4"}),
    min_height: "300px",
    width: "100%",
    max_width: "400px"
  )

  css_class(:grid_pos_1, grid_column: "1", grid_row: "1")
  css_class(:grid_pos_2, grid_column: "3", grid_row: "1")
  css_class(:grid_pos_3, grid_column: "2", grid_row: "2")
  css_class(:grid_pos_4, grid_column: "1", grid_row: "3")
  css_class(:grid_pos_5, grid_column: "3", grid_row: "3")

  css_class(:grid_anchor_1, anchor_name: "--grid-1")
  css_class(:grid_anchor_2, anchor_name: "--grid-2")
  css_class(:grid_anchor_3, anchor_name: "--grid-3")
  css_class(:grid_anchor_4, anchor_name: "--grid-4")
  css_class(:grid_anchor_5, anchor_name: "--grid-5")

  css_class(:grid_tooltip_1, position_anchor: "--grid-1")
  css_class(:grid_tooltip_2, position_anchor: "--grid-2")
  css_class(:grid_tooltip_3, position_anchor: "--grid-3")
  css_class(:grid_tooltip_4, position_anchor: "--grid-4")
  css_class(:grid_tooltip_5, position_anchor: "--grid-5")

  css_class(:grid_tooltip_base,
    position: "fixed",
    position_area: "bottom center",
    margin_top: "8px",
    position_try_fallbacks: "flip-block, flip-inline",
    opacity: %{
      :default => "0",
      When.sibling_before(":hover") => "1",
      When.sibling_before(":focus") => "1"
    },
    visibility: %{
      :default => "hidden",
      When.sibling_before(":hover") => "visible",
      When.sibling_before(":focus") => "visible"
    },
    pointer_events: "none",
    transition: "opacity 0.15s ease",
    white_space: "nowrap",
    padding: "8px 12px",
    background_color: css_var({Tokens, :colors, :gray_900}),
    color: css_var({Tokens, :colors, :white}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    z_index: "1000"
  )

  css_class(:grid_cell,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  # ============================================================================
  # Demo 3: Scrollable Container (to test fallbacks)
  # ============================================================================

  css_class(:scroll_container,
    height: "200px",
    overflow_y: "auto",
    border: "2px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"4"})
  )

  css_class(:scroll_content,
    min_height: "500px",
    display: "flex",
    flex_direction: "column",
    justify_content: "space-between",
    padding: css_const({Tokens, :space, :"4"})
  )

  css_class(:scroll_anchor,
    anchor_name: "--scroll-anchor"
  )

  css_class(:scroll_tooltip,
    position: "absolute",
    position_anchor: "--scroll-anchor",
    position_area: "bottom center",
    margin_top: "8px",
    position_try_fallbacks: "flip-block, flip-inline",
    opacity: %{
      :default => "0",
      When.sibling_before(":hover") => "1",
      When.sibling_before(":focus") => "1"
    },
    visibility: %{
      :default => "hidden",
      When.sibling_before(":hover") => "visible",
      When.sibling_before(":focus") => "visible"
    },
    pointer_events: "none",
    transition: "opacity 0.15s ease",
    white_space: "nowrap",
    padding: "8px 12px",
    background_color: css_var({Tokens, :colors, :gray_900}),
    color: css_var({Tokens, :colors, :white}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    z_index: "1000"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Anchor Positioning")}
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
          <h1 class={css_class([:page_title])}>CSS Anchor Positioning</h1>
          <div></div>
        </div>
      </header>

      <main class={css_class([:main])}>
        <%!-- Demo 1: Basic Tooltip --%>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Basic Tooltip</h2>
          <p class={css_class([:section_description])}>
            A simple tooltip anchored to a button using <code class={css_class([:code_inline])}>position-anchor</code>.
            The tooltip automatically repositions using
            <code class={css_class([:code_inline])}>position-try-fallbacks</code>
            when it would overflow the viewport.
          </p>
          <div class={css_class([:demo_container])}>
            <div style="position: relative;">
              <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}, :basic_anchor])} #{Marker.default()}"}>
                Hover me
              </button>
              <div class={css_class([:basic_tooltip])}>
                I'm anchored with pure CSS!
              </div>
            </div>
          </div>
          <div class={css_class([:browser_note])}>
            <span>⚠️</span>
            <span>Requires Chrome 125+ or browsers with Anchor Positioning support</span>
          </div>
        </section>

        <%!-- Demo 2: Grid of Anchors --%>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Grid of Anchored Tooltips</h2>
          <p class={css_class([:section_description])}>
            Multiple anchored elements in a grid layout. Each button has its own
            <code class={css_class([:code_inline])}>anchor-name</code>
            and corresponding tooltip with <code class={css_class([:code_inline])}>position-anchor</code>.
            Try scrolling the page so buttons are near viewport edges to see fallback positioning.
          </p>
          <div class={css_class([:demo_container])}>
            <div class={css_class([:grid_demo])}>
              <div class={css_class([:grid_cell, :grid_pos_1])}>
                <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}, :grid_anchor_1])} #{Marker.default()}"}>
                  ↖
                </button>
                <div class={css_class([:grid_tooltip_base, :grid_tooltip_1])}>Top-left</div>
              </div>

              <div class={css_class([:grid_cell, :grid_pos_2])}>
                <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}, :grid_anchor_2])} #{Marker.default()}"}>
                  ↗
                </button>
                <div class={css_class([:grid_tooltip_base, :grid_tooltip_2])}>Top-right</div>
              </div>

              <div class={css_class([:grid_cell, :grid_pos_3])}>
                <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}, :grid_anchor_3])} #{Marker.default()}"}>
                  ●
                </button>
                <div class={css_class([:grid_tooltip_base, :grid_tooltip_3])}>Center</div>
              </div>

              <div class={css_class([:grid_cell, :grid_pos_4])}>
                <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}, :grid_anchor_4])} #{Marker.default()}"}>
                  ↙
                </button>
                <div class={css_class([:grid_tooltip_base, :grid_tooltip_4])}>Bottom-left</div>
              </div>

              <div class={css_class([:grid_cell, :grid_pos_5])}>
                <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}, :grid_anchor_5])} #{Marker.default()}"}>
                  ↘
                </button>
                <div class={css_class([:grid_tooltip_base, :grid_tooltip_5])}>Bottom-right</div>
              </div>
            </div>
          </div>
        </section>

        <%!-- Demo 3: Scrollable Container --%>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Scrollable Container</h2>
          <p class={css_class([:section_description])}>
            With <code class={css_class([:code_inline])}>position: absolute</code>
            and a scrollable containing block,
            the tooltip repositions as you scroll. Try scrolling inside the box below.
          </p>
          <div class={css_class([:scroll_container])}>
            <div class={css_class([:scroll_content])}>
              <div style="text-align: center; color: #6b7280;">
                ↓ Scroll down ↓
              </div>

              <div style="position: relative; display: flex; justify-content: center;">
                <button class={"#{css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}, :scroll_anchor])} #{Marker.default()}"}>
                  Anchored Button
                </button>
                <div class={css_class([:scroll_tooltip])}>
                  Tooltip flips on scroll!
                </div>
              </div>

              <div style="text-align: center; color: #6b7280;">
                ↑ Scroll up ↑
              </div>
            </div>
          </div>
        </section>
      </main>
    </div>
    """
  end
end
