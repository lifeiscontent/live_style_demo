defmodule LiveStyleDemoWeb.FocusCardLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles

  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Focus Card Demo
  # ============================================================================

  css_class(:grid,
    display: "grid",
    gap: css_var({Tokens, :space, :"6"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(260px, 100%), 1fr))"
  )

  css_class(:holo_card,
    position: "relative",
    isolation: "isolate",
    overflow: "hidden",
    border_radius: css_const({Tokens, :radius, :"3xl"}),
    padding: css_var({Tokens, :space, :"6"}),
    min_height: "15rem",
    background_color: [
      default: css_var({Tokens, :semantic, :fill_glass}),
      ":hover": css_var({Tokens, :semantic, :fill_surface})
    ],
    border: "1px solid",
    border_color: [
      default: css_var({Tokens, :semantic, :border_glass}),
      ":hover": css_var({Tokens, :semantic, :border_focus})
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
      ":focus-within": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-within": "3px"]
  )

  css_class(:holo_content,
    position: "relative",
    z_index: "1",
    display: "grid",
    gap: css_var({Tokens, :space, :"3"})
  )

  css_class(:title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    margin_bottom: css_var({Tokens, :space, :"2"}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:pill,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"1.5"}),
    padding_inline: css_var({Tokens, :space, :"2.5"}),
    border_radius: css_const({Tokens, :radius, :full}),
    font_size: css_const({Tokens, :font_size, :xs}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_primary}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}"
  )

  css_class(:code,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    white_space: "pre-wrap",
    color: css_var({Tokens, :semantic, :text_secondary}),
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"4"})
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
      <div class={css_class([:grid])}>
        <div class={css_class([:holo_card])} tabindex="0">
          <div class={css_class([:holo_content])}>
            <div class={css_class([:title])}>Interactive Card</div>
            <p class={css_class([:text])}>
              Hover or focus to see the card lift and the border highlight.
              Simple, effective, and uses zero gradients.
            </p>

            <div class={css_class([:pill])}>Clean CSS visuals</div>
          </div>
        </div>

        <div class={css_class([{BaseStyles, :card_base}])}>
          <div class={css_class([:title])}>Recipe</div>
          <p class={css_class([:text])}>
            Uses standard CSS transitions on transform and border-color.
          </p>

          <pre class={css_class([:code])}>
    .card:hover &#123;
      transform: translateY(-4px);
      border-color: var(--border-focus);
      background-color: var(--fill-surface);
    &#125;
          </pre>

          <.link
            navigate={~p"/color"}
            class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
          >
            Next: Color demo
          </.link>
        </div>
      </div>
    </.shell>
    """
  end
end
