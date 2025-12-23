defmodule LiveStyleDemoWeb.TableLive do
  @moduledoc """
  Demo showcasing a styled table with LiveStyle.

  This demo replicates the StyleX table example with cross-highlight effects
  using LiveStyle.When contextual selectors.

  StyleX equivalent:
  - `when.ancestor(":hover")` → `When.ancestor(":hover")`
  - `when.ancestor(":hover", ROW)` → `When.ancestor(":hover", Tokens.row_marker())`
  - `stylex.defaultMarker()` → `Marker.default()`
  """
  use LiveStyleDemoWeb, :live_view

  alias LiveStyle.Marker
  alias LiveStyle.When

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # Theme-aware table highlight (replaces StyleX demo's hardcoded teal)
  @highlight css_var({Tokens, :semantic, :highlight_primary})

  # Get the ROW marker from Tokens
  @row_marker Tokens.row_marker()

  # ============================================================================
  # Container styles (matching StyleX)
  # ============================================================================

  css_class(:container,
    padding: [
      default: css_var({Tokens, :space, :"4"}),
      "@media (min-width: 640px)": css_var({Tokens, :space, :"8"})
    ],
    margin_block: [
      default: "0",
      "@media (min-width: 640px)": css_var({Tokens, :space, :"4"})
    ],
    margin_inline: "auto",
    max_width: "64rem",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}"
  )

  css_class(:table_scroll,
    width: "100%",
    overflow_x: "auto",
    overscroll_behavior_x: "contain",
    "-webkit-overflow-scrolling": "touch"
  )

  css_class(:table,
    width: "100%",
    min_width: "560px",
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_glass}),
    border_radius: css_const({Tokens, :radius, :lg})
  )

  # ============================================================================
  # Cell styles with cross-highlight effects (matching StyleX)
  # ============================================================================

  # Column highlight selectors generated dynamically (like StyleX's Object.fromEntries)
  @column_opacity Map.new(2..8, fn n ->
                    {":nth-child(#{n})",
                     %{
                       :default => nil,
                       When.ancestor(":has(td:nth-of-type(#{n}):hover)") => "1"
                     }}
                  end)

  @column_background Map.new(2..8, fn n ->
                       {":nth-child(#{n})",
                        %{
                          :default => nil,
                          When.ancestor(":has(td:nth-of-type(#{n}):hover)") => @highlight
                        }}
                     end)

  css_class(:td,
    text_align: %{
      :default => "center",
      ":first-child" => "right"
    },
    padding_block: css_var({Tokens, :space, :"1"}),
    padding_inline: css_var({Tokens, :space, :"2"}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    font_weight: "200",
    opacity:
      Map.merge(
        %{
          :default => "1",
          # Fade out all cells when hovering anywhere in the container
          When.ancestor(":hover") => "0.1",
          # Keep cells in the hovered row visible
          When.ancestor(":hover", @row_marker) => "1",
          # Keep the hovered cell visible
          ":hover" => "1"
        },
        # Column highlight: keep cells in the same column as hovered cell visible
        @column_opacity
      ),
    background_color:
      Map.merge(
        %{
          :default => "transparent",
          # Highlight row on hover
          When.ancestor(":hover", @row_marker) => @highlight,

          # Highlight hovered cell
          ":hover" => %{
            :default => @highlight,
            ":nth-child(1)" => "transparent"
          },
          # First column never gets background
          ":nth-child(1)" => "transparent"
        },
        # Column highlight: highlight cells in same column as hovered cell
        @column_background
      )
  )

  # Header cell style
  css_class(:th,
    color: css_var({Tokens, :semantic, :text_primary}),
    font_weight: "800",
    background_color: "transparent"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

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
    <.shell
      active="table"
      page_title="Price Table"
      page_subtitle="A dense table with :has()-powered cross-highlighting."
    >
      <div class={container_class()}>
        <div class={css_class([:table_scroll])}>
          <table class={css_class([:table])}>
            <thead>
              <.tr>
                <.th></.th>
                <.th>Mon</.th>
                <.th>Tue</.th>
                <.th>Wed</.th>
                <.th>Thu</.th>
                <.th>Fri</.th>
                <.th>Sat</.th>
                <.th>Sun</.th>
              </.tr>
            </thead>
            <tbody>
              <.tr>
                <.td>08:00-09:00</.td>
                <.td>-</.td>
                <.td>-</.td>
                <.td>-</.td>
                <.td>$120</.td>
                <.td>$130</.td>
                <.td>$140</.td>
                <.td>$160</.td>
              </.tr>
              <.tr>
                <.td>09:00-10:00</.td>
                <.td>-</.td>
                <.td>-</.td>
                <.td>$120</.td>
                <.td>$130</.td>
                <.td>$140</.td>
                <.td>$150</.td>
                <.td>$170</.td>
              </.tr>
              <.tr>
                <.td>11:00-12:00</.td>
                <.td>$120</.td>
                <.td>$130</.td>
                <.td>$130</.td>
                <.td>$140</.td>
                <.td>$150</.td>
                <.td>$160</.td>
                <.td>$180</.td>
              </.tr>
              <.tr>
                <.td>12:00-13:00</.td>
                <.td>$120</.td>
                <.td>$130</.td>
                <.td>$130</.td>
                <.td>$140</.td>
                <.td>$150</.td>
                <.td>$160</.td>
                <.td>$180</.td>
              </.tr>
              <.tr>
                <.td>13:00-14:00</.td>
                <.td>$120</.td>
                <.td>$130</.td>
                <.td>$130</.td>
                <.td>$140</.td>
                <.td>$150</.td>
                <.td>$160</.td>
                <.td>$180</.td>
              </.tr>
              <.tr>
                <.td>14:00-15:00</.td>
                <.td>$120</.td>
                <.td>$130</.td>
                <.td>$130</.td>
                <.td>$140</.td>
                <.td>$150</.td>
                <.td>$160</.td>
                <.td>$180</.td>
              </.tr>
            </tbody>
          </table>
        </div>
      </div>
    </.shell>
    """
  end

  # ============================================================================
  # Components
  # ============================================================================

  defp tr(assigns) do
    ~H"""
    <tr class={Tokens.row_marker()}>{render_slot(@inner_block)}</tr>
    """
  end

  defp th(assigns) do
    ~H"""
    <th class={css_class([:td, :th])}>{render_slot(@inner_block)}</th>
    """
  end

  defp td(assigns) do
    ~H"""
    <td class={css_class([:td])}>{render_slot(@inner_block)}</td>
    """
  end

  # Container with default marker for cross-highlight effects
  defp container_class do
    css_class([:container]) <> " " <> Marker.default()
  end
end
