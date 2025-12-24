defmodule LiveStyleDemoWeb.AnchorLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyle.Marker
  alias LiveStyle.When

  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  css_class(:demo_container,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px dashed",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: [
      default: css_var({Tokens, :space, :"4"}),
      "@media (min-width: 640px)": css_var({Tokens, :space, :"8"})
    ],
    min_height: "300px",
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  css_class(:relative,
    position: "relative"
  )

  css_class(:scroll_hint,
    text_align: "center",
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:center_relative,
    position: "relative",
    display: "flex",
    justify_content: "center"
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
    margin_top: css_var({Tokens, :space, :"2"}),
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
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    z_index: "1000"
  )

  # ==========================================================================
  # Demo 2: Grid of Anchors
  # ==========================================================================

  css_class(:grid_demo,
    width: "min(28rem, 100%)",
    margin_inline: "auto",
    display: "grid",
    grid_template_columns: "repeat(3, minmax(0, 1fr))",
    grid_template_rows: "repeat(3, minmax(4.5rem, auto))",
    gap: css_var({Tokens, :space, :"3"})
  )

  css_class(:grid_cell,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  css_class(:grid_pos_1, grid_column: "1", grid_row: "1")
  css_class(:grid_pos_2, grid_column: "3", grid_row: "1")
  css_class(:grid_pos_3, grid_column: "2", grid_row: "2")
  css_class(:grid_pos_4, grid_column: "1", grid_row: "3")
  css_class(:grid_pos_5, grid_column: "3", grid_row: "3")

  css_class(:grid_anchor_1, anchor_name: "--grid-anchor-1")
  css_class(:grid_anchor_2, anchor_name: "--grid-anchor-2")
  css_class(:grid_anchor_3, anchor_name: "--grid-anchor-3")
  css_class(:grid_anchor_4, anchor_name: "--grid-anchor-4")
  css_class(:grid_anchor_5, anchor_name: "--grid-anchor-5")

  css_class(:grid_tooltip_base,
    position: "fixed",
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
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    z_index: "1000"
  )

  css_class(:grid_tooltip_1,
    position_anchor: "--grid-anchor-1",
    position_area: "top left",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: css_var({Tokens, :space, :"2"})
  )

  css_class(:grid_tooltip_2,
    position_anchor: "--grid-anchor-2",
    position_area: "top right",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: css_var({Tokens, :space, :"2"})
  )

  css_class(:grid_tooltip_3,
    position_anchor: "--grid-anchor-3",
    position_area: "top center",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: css_var({Tokens, :space, :"2"})
  )

  css_class(:grid_tooltip_4,
    position_anchor: "--grid-anchor-4",
    position_area: "bottom left",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: css_var({Tokens, :space, :"2"})
  )

  css_class(:grid_tooltip_5,
    position_anchor: "--grid-anchor-5",
    position_area: "bottom right",
    position_try_fallbacks: "flip-block, flip-inline",
    margin: css_var({Tokens, :space, :"2"})
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
    padding: css_var({Tokens, :space, :"4"})
  )

  css_class(:scroll_content,
    min_height: "500px",
    display: "flex",
    flex_direction: "column",
    justify_content: "space-between",
    padding: css_var({Tokens, :space, :"4"})
  )

  css_class(:scroll_anchor,
    anchor_name: "--scroll-anchor"
  )

  css_class(:scroll_tooltip,
    position: "absolute",
    position_anchor: "--scroll-anchor",
    position_area: "bottom center",
    margin_top: css_var({Tokens, :space, :"2"}),
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
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
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
        <div class={css_class([:demo_container])}>
          <div class={css_class([:relative])}>
            <.button
              variant={:primary}
              class={"#{css_class([:basic_anchor])} #{Marker.default()}"}
            >
              Hover me
            </.button>
            <div class={css_class([:basic_tooltip])}>
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
        <div class={css_class([:demo_container])}>
          <div class={css_class([:grid_demo])}>
            <div class={css_class([:grid_cell, :grid_pos_1])}>
              <.button
                variant={:secondary}
                class={"#{css_class([:grid_anchor_1])} #{Marker.default()}"}
              >
                ↖
              </.button>
              <div class={css_class([:grid_tooltip_base, :grid_tooltip_1])}>Top-left</div>
            </div>

            <div class={css_class([:grid_cell, :grid_pos_2])}>
              <.button
                variant={:secondary}
                class={"#{css_class([:grid_anchor_2])} #{Marker.default()}"}
              >
                ↗
              </.button>
              <div class={css_class([:grid_tooltip_base, :grid_tooltip_2])}>Top-right</div>
            </div>

            <div class={css_class([:grid_cell, :grid_pos_3])}>
              <.button
                variant={:primary}
                class={"#{css_class([:grid_anchor_3])} #{Marker.default()}"}
              >
                ●
              </.button>
              <div class={css_class([:grid_tooltip_base, :grid_tooltip_3])}>Center</div>
            </div>

            <div class={css_class([:grid_cell, :grid_pos_4])}>
              <.button
                variant={:secondary}
                class={"#{css_class([:grid_anchor_4])} #{Marker.default()}"}
              >
                ↙
              </.button>
              <div class={css_class([:grid_tooltip_base, :grid_tooltip_4])}>Bottom-left</div>
            </div>

            <div class={css_class([:grid_cell, :grid_pos_5])}>
              <.button
                variant={:secondary}
                class={"#{css_class([:grid_anchor_5])} #{Marker.default()}"}
              >
                ↘
              </.button>
              <div class={css_class([:grid_tooltip_base, :grid_tooltip_5])}>Bottom-right</div>
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
        <div class={css_class([:scroll_container])}>
          <div class={css_class([:scroll_content])}>
            <div class={css_class([:scroll_hint])}>↓ Scroll down ↓</div>

            <div class={css_class([:center_relative])}>
              <.button
                variant={:primary}
                class={"#{css_class([:scroll_anchor])} #{Marker.default()}"}
              >
                Anchored Button
              </.button>
              <div class={css_class([:scroll_tooltip])}>
                Tooltip flips on scroll!
              </div>
            </div>

            <div class={css_class([:scroll_hint])}>↑ Scroll up ↑</div>
          </div>
        </div>
      </.demo_section>
    </.shell>
    """
  end
end
