defmodule LiveStyleDemoWeb.FocusCardLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  # ============================================================================
  # Focus Card Demo
  # ============================================================================

  class(:grid,
    display: "grid",
    gap: var({Space, :"6"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(260px, 100%), 1fr))"
  )

  class(:focus_card,
    position: "relative",
    isolation: "isolate",
    overflow: "hidden",
    border_radius: const({Tokens, :radius_3xl}),
    padding: var({Space, :"6"}),
    min_height: "15rem",
    background_color: [
      default: var({Semantic, :fill_glass}),
      ":hover": var({Semantic, :fill_surface})
    ],
    border: "1px solid",
    border_color: [
      default: var({Semantic, :border_glass}),
      ":hover": var({Semantic, :border_focus})
    ],
    box_shadow: "none",
    transform: [
      default: "translateY(0)",
      ":hover": "translateY(-4px)",
      ":focus-within": "translateY(-4px)",
      ":active": "translateY(-2px)"
    ],
    transition: "transform 180ms ease, background-color 180ms ease, border-color 180ms ease",
    outline: [
      default: "none",
      ":focus-within": "2px solid #{var({Semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-within": "3px"]
  )

  class(:card_content,
    position: "relative",
    z_index: "1",
    display: "grid",
    gap: var({Space, :"3"})
  )

  class(:title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    margin_bottom: var({Space, :"2"}),
    color: var({Semantic, :text_primary})
  )

  class(:text,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed}),
    margin_bottom: var({Space, :"4"})
  )

  class(:pill,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    padding_block: var({Space, :"1.5"}),
    padding_inline: var({Space, :"2.5"}),
    border_radius: const({Tokens, :radius_full}),
    font_size: const({Tokens, :font_size_xs}),
    font_weight: const({Tokens, :font_weight_medium}),
    color: var({Semantic, :text_primary}),
    background_color: var({Semantic, :fill_muted}),
    border: "1px solid #{var({Semantic, :border_glass})}"
  )

  class(:code,
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_sm}),
    line_height: const({Tokens, :leading_relaxed}),
    white_space: "pre-wrap",
    color: var({Semantic, :text_secondary}),
    background_color: var({Semantic, :fill_surface}),
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_lg}),
    padding: var({Space, :"4"})
  )

  class(:card_inner,
    padding: var({Space, :"6"}),
    display: "flex",
    flex_direction: "column",
    gap: var({Space, :"4"})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Focus Card")
     |> push_event("start-view-transition", %{type: "page"}, dispatch: :before)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="focus-card"
      page_title="Focus Card"
      page_subtitle="A highly interactive card using only solid colors and borders."
    >
      <div {css(:grid)}>
        <div {css(:focus_card)} tabindex="0">
          <div {css(:card_content)}>
            <div {css(:title)}>Interactive Card</div>
            <p {css(:text)}>
              Hover or focus to see the card lift and the border highlight.
              Simple, effective, and uses zero gradients.
            </p>

            <div {css(:pill)}>Clean CSS visuals</div>
          </div>
        </div>

        <.card>
          <div {css(:card_inner)}>
            <div>
              <div {css(:title)}>Recipe</div>
              <p {css(:text)}>
                Uses standard CSS transitions on transform and border-color.
              </p>
            </div>

            <pre {css(:code)}>
    .card:hover &#123;
      transform: translateY(-4px);
      border-color: var(--border-focus);
      background-color: var(--fill-surface);
    &#125;
            </pre>
          </div>
        </.card>
      </div>
    </.shell>
    """
  end
end
