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

  # Colors matching StyleX demo
  @teal "#2266cc77"

  # Get the ROW marker from Tokens
  @row_marker Tokens.row_marker()

  # ============================================================================
  # Page Layout
  # ============================================================================

  css_class(:page,
    min_height: "100vh",
    background_color: "light-dark(#f3f4f6, #111827)",
    font_family: css_const({Tokens, :font, :sans})
  )

  css_class(:back_link,
    display: "inline-flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    color: "light-dark(#6b7280, #9ca3af)",
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    text_decoration: "none",
    padding: css_const({Tokens, :space, :"4"}),
    transition: "color 0.2s ease"
  )

  css_class(:content,
    padding_bottom: css_const({Tokens, :space, :"16"})
  )

  css_class(:header,
    text_align: "center",
    padding_top: css_const({Tokens, :space, :"8"}),
    padding_bottom: css_const({Tokens, :space, :"4"})
  )

  css_class(:title,
    font_size: css_const({Tokens, :font_size, :"2xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: "light-dark(#111827, #f9fafb)",
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:subtitle,
    font_size: css_const({Tokens, :font_size, :base}),
    color: "light-dark(#6b7280, #9ca3af)",
    max_width: "32rem",
    margin_left: "auto",
    margin_right: "auto"
  )

  # ============================================================================
  # Container styles (matching StyleX)
  # ============================================================================

  css_class(:container,
    background_color: "light-dark(#fff, #000)",
    padding: "32px",
    margin: "16px",
    margin_left: "auto",
    margin_right: "auto",
    max_width: "64rem",
    border_radius: "12px"
  )

  css_class(:table,
    width: "100%",
    border_width: "1px",
    border_style: "solid",
    border_color: "light-dark(rgba(0,0,0,0.1), rgba(255,255,255,0.1))",
    border_radius: "4px"
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
                          When.ancestor(":has(td:nth-of-type(#{n}):hover)") => @teal
                        }}
                     end)

  css_class(:td,
    text_align: %{
      :default => "center",
      ":first-child" => "right"
    },
    padding: "4px",
    padding_inline: "8px",
    color: "light-dark(#333, #aaa)",
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
          When.ancestor(":hover", @row_marker) => @teal,
          # Highlight hovered cell
          ":hover" => %{
            :default => @teal,
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
    color: "light-dark(#000, #fff)",
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
    <div class={css_class([:page])}>
      <.link navigate="/" class={css_class([:back_link])}>
        &#8592; Back to Home
      </.link>
      <div class={css_class([:content])}>
        <div class={css_class([:header])}>
          <h1 class={css_class([:title])}>Price Table</h1>
          <p class={css_class([:subtitle])}>
            A styled table demo using LiveStyle with cross-highlight effects.
            Hover over cells to see row and column highlighting.
          </p>
        </div>
        <div class={container_class()}>
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
    </div>
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
