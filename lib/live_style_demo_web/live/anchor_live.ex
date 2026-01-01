defmodule LiveStyleDemoWeb.AnchorLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyle.Marker
  alias LiveStyle.When

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:demo_container,
    background_color: var({Semantic, :fill_page}),
    border: "1px dashed",
    border_color: var({Semantic, :border_subtle}),
    border_radius: const({Tokens, :radius_lg}),
    padding: [
      default: var({Space, :"4"}),
      "@media (min-width: 640px)": var({Space, :"8"})
    ],
    min_height: "300px",
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  class(:relative,
    position: "relative"
  )

  class(:scroll_hint,
    text_align: "center",
    color: var({Semantic, :text_muted})
  )

  class(:center_relative,
    position: "relative",
    display: "flex",
    justify_content: "center"
  )

  # ============================================================================
  # Demo 1: Basic Tooltip with Anchor Positioning
  # ============================================================================

  class(:basic_anchor,
    anchor_name: "--basic-anchor"
  )

  class(:basic_tooltip,
    position: "fixed",
    position_anchor: "--basic-anchor",
    position_area: "bottom center",
    margin_top: var({Space, :"2"}),
    position_try_fallbacks: "flip-block, flip-inline",
    # Hidden by default
    opacity: [
      {:default, "0"},
      {When.sibling_before(":hover"), "1"},
      {When.sibling_before(":focus"), "1"}
    ],
    visibility: [
      {:default, "hidden"},
      {When.sibling_before(":hover"), "visible"},
      {When.sibling_before(":focus"), "visible"}
    ],
    pointer_events: "none",
    transition: "opacity 0.15s ease",
    # Styling
    white_space: "nowrap",
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    font_size: const({Tokens, :font_size_sm}),
    border_radius: const({Tokens, :radius_md}),
    box_shadow: const({Tokens, :shadow_lg}),
    z_index: "1000"
  )

  # ==========================================================================
  # Demo 2: Grid of Anchors
  # ==========================================================================

  class(:grid_demo,
    width: "min(28rem, 100%)",
    margin_inline: "auto",
    display: "grid",
    grid_template_columns: "repeat(3, minmax(0, 1fr))",
    grid_template_rows: "repeat(3, minmax(4.5rem, auto))",
    gap: var({Space, :"3"})
  )

  class(:grid_cell,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  class(:grid_pos_1, grid_column: "1", grid_row: "1")
  class(:grid_pos_2, grid_column: "3", grid_row: "1")
  class(:grid_pos_3, grid_column: "2", grid_row: "2")
  class(:grid_pos_4, grid_column: "1", grid_row: "3")
  class(:grid_pos_5, grid_column: "3", grid_row: "3")

  class(:grid_anchor_1, anchor_name: "--grid-anchor-1")
  class(:grid_anchor_2, anchor_name: "--grid-anchor-2")
  class(:grid_anchor_3, anchor_name: "--grid-anchor-3")
  class(:grid_anchor_4, anchor_name: "--grid-anchor-4")
  class(:grid_anchor_5, anchor_name: "--grid-anchor-5")

  class(:grid_tooltip_base,
    position: "fixed",
    opacity: [
      {:default, "0"},
      {When.sibling_before(":hover"), "1"},
      {When.sibling_before(":focus"), "1"}
    ],
    visibility: [
      {:default, "hidden"},
      {When.sibling_before(":hover"), "visible"},
      {When.sibling_before(":focus"), "visible"}
    ],
    pointer_events: "none",
    transition: "opacity 0.15s ease",
    white_space: "nowrap",
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    font_size: const({Tokens, :font_size_sm}),
    border_radius: const({Tokens, :radius_md}),
    box_shadow: const({Tokens, :shadow_lg}),
    z_index: "1000"
  )

  class(:grid_tooltip_1,
    position_anchor: "--grid-anchor-1",
    position_area: "top left",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: var({Space, :"2"})
  )

  class(:grid_tooltip_2,
    position_anchor: "--grid-anchor-2",
    position_area: "top right",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: var({Space, :"2"})
  )

  class(:grid_tooltip_3,
    position_anchor: "--grid-anchor-3",
    position_area: "top center",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: var({Space, :"2"})
  )

  class(:grid_tooltip_4,
    position_anchor: "--grid-anchor-4",
    position_area: "bottom left",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: var({Space, :"2"})
  )

  class(:grid_tooltip_5,
    position_anchor: "--grid-anchor-5",
    position_area: "bottom right",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: var({Space, :"2"})
  )

  # ============================================================================
  # Demo 3: Scrollable Container (to test fallbacks)
  # ============================================================================

  class(:scroll_container,
    height: "200px",
    overflow_y: "auto",
    border: "2px solid",
    border_color: var({Semantic, :border_subtle}),
    border_radius: const({Tokens, :radius_lg}),
    padding: var({Space, :"4"})
  )

  class(:scroll_content,
    min_height: "500px",
    display: "flex",
    flex_direction: "column",
    justify_content: "space-between",
    padding: var({Space, :"4"})
  )

  class(:scroll_anchor,
    anchor_name: "--scroll-anchor"
  )

  class(:scroll_tooltip,
    position: "absolute",
    position_anchor: "--scroll-anchor",
    position_area: "bottom center",
    margin_top: var({Space, :"2"}),
    position_try_fallbacks: "flip-block, flip-inline",
    opacity: [
      {:default, "0"},
      {When.sibling_before(":hover"), "1"},
      {When.sibling_before(":focus"), "1"}
    ],
    visibility: [
      {:default, "hidden"},
      {When.sibling_before(":hover"), "visible"},
      {When.sibling_before(":focus"), "visible"}
    ],
    pointer_events: "none",
    transition: "opacity 0.15s ease",
    white_space: "nowrap",
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    font_size: const({Tokens, :font_size_sm}),
    border_radius: const({Tokens, :radius_md}),
    box_shadow: const({Tokens, :shadow_lg}),
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
    <.shell
      active="anchor"
      page_title="CSS Anchor Positioning"
      page_subtitle="Anchor tooltips + smart fallbacks with pure CSS."
    >
      <%!-- Demo 1: Basic Tooltip --%>
      <.demo_section>
        <.demo_section_title>Basic Tooltip</.demo_section_title>
        <.demo_section_description>
          A simple tooltip anchored to a button using <.code_inline>position-anchor</.code_inline>.
          The tooltip automatically repositions using
          <.code_inline>position-try-fallbacks</.code_inline>
          when it would overflow the viewport.
        </.demo_section_description>
        <div {css(:demo_container)}>
          <div {css(:relative)}>
            <.button
              variant={:primary}
              {css([:basic_anchor, Marker.default()])}
            >
              Hover me
            </.button>
            <div {css(:basic_tooltip)}>
              I'm anchored with pure CSS!
            </div>
          </div>
        </div>
        <.browser_note>
          <span>⚠️</span>
          <span>Requires Chrome 125+ or browsers with Anchor Positioning support</span>
        </.browser_note>
      </.demo_section>

      <%!-- Demo 2: Grid of Anchors --%>
      <.demo_section>
        <.demo_section_title>Grid of Anchored Tooltips</.demo_section_title>
        <.demo_section_description>
          Multiple anchored elements in a grid layout. Each button has its own
          <.code_inline>anchor-name</.code_inline>
          and corresponding tooltip with <.code_inline>position-anchor</.code_inline>.
          Try scrolling the page so buttons are near viewport edges to see fallback positioning.
        </.demo_section_description>
        <div {css(:demo_container)}>
          <div {css(:grid_demo)}>
            <div {css([:grid_cell, :grid_pos_1])}>
              <.button
                variant={:secondary}
                {css([:grid_anchor_1, Marker.default()])}
              >
                ↖
              </.button>
              <div {css([:grid_tooltip_base, :grid_tooltip_1])}>Top-left</div>
            </div>

            <div {css([:grid_cell, :grid_pos_2])}>
              <.button
                variant={:secondary}
                {css([:grid_anchor_2, Marker.default()])}
              >
                ↗
              </.button>
              <div {css([:grid_tooltip_base, :grid_tooltip_2])}>Top-right</div>
            </div>

            <div {css([:grid_cell, :grid_pos_3])}>
              <.button
                variant={:primary}
                {css([:grid_anchor_3, Marker.default()])}
              >
                ●
              </.button>
              <div {css([:grid_tooltip_base, :grid_tooltip_3])}>Center</div>
            </div>

            <div {css([:grid_cell, :grid_pos_4])}>
              <.button
                variant={:secondary}
                {css([:grid_anchor_4, Marker.default()])}
              >
                ↙
              </.button>
              <div {css([:grid_tooltip_base, :grid_tooltip_4])}>Bottom-left</div>
            </div>

            <div {css([:grid_cell, :grid_pos_5])}>
              <.button
                variant={:secondary}
                {css([:grid_anchor_5, Marker.default()])}
              >
                ↘
              </.button>
              <div {css([:grid_tooltip_base, :grid_tooltip_5])}>Bottom-right</div>
            </div>
          </div>
        </div>
      </.demo_section>

      <%!-- Demo 3: Scrollable Container --%>
      <.demo_section>
        <.demo_section_title>Scrollable Container</.demo_section_title>
        <.demo_section_description>
          With
          <.code_inline>position: absolute</.code_inline>
          and a scrollable containing block,
          the tooltip repositions as you scroll. Try scrolling inside the box below.
        </.demo_section_description>
        <div {css(:scroll_container)}>
          <div {css(:scroll_content)}>
            <div {css(:scroll_hint)}>↓ Scroll down ↓</div>

            <div {css(:center_relative)}>
              <.button
                variant={:primary}
                {css([:scroll_anchor, Marker.default()])}
              >
                Anchored Button
              </.button>
              <div {css(:scroll_tooltip)}>
                Tooltip flips on scroll!
              </div>
            </div>

            <div {css(:scroll_hint)}>↑ Scroll up ↑</div>
          </div>
        </div>
      </.demo_section>
    </.shell>
    """
  end
end
