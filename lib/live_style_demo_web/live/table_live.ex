defmodule LiveStyleDemoWeb.TableLive do
  @moduledoc """
  Demo showcasing cross-highlight table effect with pure CSS using LiveStyle.When.

  This is a direct port of the StyleX table demo.
  """
  use LiveStyleDemoWeb, :live_view
  use LiveStyle
  import LiveStyle.When

  # Markers - like StyleX's defineMarker()
  @row_marker LiveStyle.define_marker(:row)

  # Pre-compute selectors
  @any_ancestor_hover ancestor(":hover")
  @row_hover ancestor(":hover", @row_marker)

  # Column selectors for columns 2-8 (matching StyleX)
  @col2_has_hover ancestor(":has(td:nth-of-type(2):hover)")
  @col3_has_hover ancestor(":has(td:nth-of-type(3):hover)")
  @col4_has_hover ancestor(":has(td:nth-of-type(4):hover)")
  @col5_has_hover ancestor(":has(td:nth-of-type(5):hover)")
  @col6_has_hover ancestor(":has(td:nth-of-type(6):hover)")
  @col7_has_hover ancestor(":has(td:nth-of-type(7):hover)")
  @col8_has_hover ancestor(":has(td:nth-of-type(8):hover)")

  # Colors matching StyleX demo
  @teal "#2266cc77"

  # ============================================================================
  # Page Layout
  # ============================================================================

  style(:page,
    min_height: "100vh",
    background_color: "light-dark(#f3f4f6, #111827)",
    font_family: var(:font_sans)
  )

  style(:back_link,
    display: "inline-flex",
    align_items: "center",
    gap: var(:space_2),
    color: "light-dark(#6b7280, #9ca3af)",
    font_size: var(:text_size_sm),
    font_weight: var(:font_weight_medium),
    text_decoration: "none",
    padding: var(:space_4),
    transition: "color 0.2s ease",
    ":hover": [
      color: "light-dark(#374151, #f9fafb)"
    ]
  )

  style(:content,
    padding_bottom: var(:space_16)
  )

  style(:header,
    text_align: "center",
    padding_top: var(:space_8),
    padding_bottom: var(:space_4)
  )

  style(:title,
    font_size: var(:text_size_2xl),
    font_weight: var(:font_weight_bold),
    color: "light-dark(#111827, #f9fafb)",
    margin_bottom: var(:space_2)
  )

  style(:subtitle,
    font_size: var(:text_size_base),
    color: "light-dark(#6b7280, #9ca3af)",
    max_width: "32rem",
    margin_left: "auto",
    margin_right: "auto"
  )

  # ============================================================================
  # Container styles - matching StyleX
  # ============================================================================

  style(:container,
    background_color: "light-dark(#fff, #000)",
    padding: "32px",
    margin_left: "auto",
    margin_right: "auto",
    max_width: "64rem",
    border_radius: "12px"
  )

  style(:table,
    width: "100%",
    border_width: "1px",
    border_style: "solid",
    border_color: "light-dark(rgba(0,0,0,0.1), rgba(255,255,255,0.1))",
    border_radius: "4px"
  )

  # ============================================================================
  # Cell styles - matching StyleX exactly
  # ============================================================================

  # Base td style matching StyleX's td style exactly
  # Uses nested conditions for :nth-child combined with when.ancestor
  style(:td,
    text_align: [
      default: "center",
      ":first-child": "right"
    ],
    padding: "4px",
    padding_inline: "8px",
    color: "light-dark(#333, #aaa)",
    font_weight: "200",
    opacity:
      conditions([
        {:default, "1"},
        {@any_ancestor_hover, "0.1"},
        {@row_hover, "1"},
        {":hover", "1"},
        # Per-column opacity restore using nested conditions
        {":nth-child(2)",
         %{
           :default => nil,
           @col2_has_hover => "1"
         }},
        {":nth-child(3)",
         %{
           :default => nil,
           @col3_has_hover => "1"
         }},
        {":nth-child(4)",
         %{
           :default => nil,
           @col4_has_hover => "1"
         }},
        {":nth-child(5)",
         %{
           :default => nil,
           @col5_has_hover => "1"
         }},
        {":nth-child(6)",
         %{
           :default => nil,
           @col6_has_hover => "1"
         }},
        {":nth-child(7)",
         %{
           :default => nil,
           @col7_has_hover => "1"
         }},
        {":nth-child(8)",
         %{
           :default => nil,
           @col8_has_hover => "1"
         }}
      ]),
    background_color:
      conditions([
        {:default, "transparent"},
        {@row_hover, @teal},
        {":hover",
         %{
           :default => @teal,
           ":nth-child(1)" => "transparent"
         }},
        {":nth-child(1)", "transparent"},
        # Per-column background highlight using nested conditions
        {":nth-child(2)",
         %{
           :default => nil,
           @col2_has_hover => @teal
         }},
        {":nth-child(3)",
         %{
           :default => nil,
           @col3_has_hover => @teal
         }},
        {":nth-child(4)",
         %{
           :default => nil,
           @col4_has_hover => @teal
         }},
        {":nth-child(5)",
         %{
           :default => nil,
           @col5_has_hover => @teal
         }},
        {":nth-child(6)",
         %{
           :default => nil,
           @col6_has_hover => @teal
         }},
        {":nth-child(7)",
         %{
           :default => nil,
           @col7_has_hover => @teal
         }},
        {":nth-child(8)",
         %{
           :default => nil,
           @col8_has_hover => @teal
         }}
      ])
  )

  # Header cell style
  style(:th,
    __include__: [:td],
    color: "light-dark(#000, #fff)",
    font_weight: "800",
    background_color: "transparent"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  def row_marker, do: @row_marker

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Table Demo")
     |> push_event("start-view-transition", %{type: "page"}, dispatch: :before)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class={style([:page])}>
      <.link navigate="/" class={style([:back_link])}>
        &#8592; Back to Home
      </.link>
      <div class={style([:content])}>
        <div class={style([:header])}>
          <h1 class={style([:title])}>Cross-Highlight Table</h1>
          <p class={style([:subtitle])}>
            Hover over any cell to see the row and column highlight effect.
            Built with pure CSS using LiveStyle.When contextual selectors.
          </p>
        </div>
        <div class={"#{style([:container])} #{LiveStyle.default_marker()}"}>
          <table class={style([:table])}>
            <tr class={row_marker()}>
              <td class={style([:th])}></td>
              <td class={style([:th])}>Mon</td>
              <td class={style([:th])}>Tue</td>
              <td class={style([:th])}>Wed</td>
              <td class={style([:th])}>Thu</td>
              <td class={style([:th])}>Fri</td>
              <td class={style([:th])}>Sat</td>
              <td class={style([:th])}>Sun</td>
            </tr>
            <tr class={row_marker()}>
              <td class={style([:td])}>08:00-09:00</td>
              <td class={style([:td])}>-</td>
              <td class={style([:td])}>-</td>
              <td class={style([:td])}>-</td>
              <td class={style([:td])}>$120</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$140</td>
              <td class={style([:td])}>$160</td>
            </tr>
            <tr class={row_marker()}>
              <td class={style([:td])}>09:00-10:00</td>
              <td class={style([:td])}>-</td>
              <td class={style([:td])}>-</td>
              <td class={style([:td])}>$120</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$140</td>
              <td class={style([:td])}>$150</td>
              <td class={style([:td])}>$170</td>
            </tr>
            <tr class={row_marker()}>
              <td class={style([:td])}>11:00-12:00</td>
              <td class={style([:td])}>$120</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$140</td>
              <td class={style([:td])}>$150</td>
              <td class={style([:td])}>$160</td>
              <td class={style([:td])}>$180</td>
            </tr>
            <tr class={row_marker()}>
              <td class={style([:td])}>12:00-13:00</td>
              <td class={style([:td])}>$120</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$140</td>
              <td class={style([:td])}>$150</td>
              <td class={style([:td])}>$160</td>
              <td class={style([:td])}>$180</td>
            </tr>
            <tr class={row_marker()}>
              <td class={style([:td])}>13:00-14:00</td>
              <td class={style([:td])}>$120</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$140</td>
              <td class={style([:td])}>$150</td>
              <td class={style([:td])}>$160</td>
              <td class={style([:td])}>$180</td>
            </tr>
            <tr class={row_marker()}>
              <td class={style([:td])}>14:00-15:00</td>
              <td class={style([:td])}>$120</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$130</td>
              <td class={style([:td])}>$140</td>
              <td class={style([:td])}>$150</td>
              <td class={style([:td])}>$160</td>
              <td class={style([:td])}>$180</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    """
  end
end
