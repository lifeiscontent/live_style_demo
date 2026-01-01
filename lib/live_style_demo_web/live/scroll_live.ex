defmodule LiveStyleDemoWeb.ScrollLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  # ============================================================================
  # Demo 1: Reading Progress Bar
  # ============================================================================

  keyframes(:grow_progress,
    from: %{transform: "scaleX(0)"},
    to: %{transform: "scaleX(1)"}
  )

  class(:progress_bar,
    position: "fixed",
    top: "0",
    left: "0",
    width: "100%",
    height: "4px",
    background: var({Semantic, :fill_primary}),
    transform_origin: "left",
    z_index: "200",
    # Scroll-driven animation
    animation_name: keyframes(:grow_progress),
    animation_timeline: "scroll()",
    animation_timing_function: "linear"
  )

  # ============================================================================
  # Demo 2: Reveal on Scroll
  # ============================================================================

  class(:scroll_content,
    min_height: "150vh",
    padding: var({Space, :"8"})
  )

  keyframes(:reveal,
    from: %{opacity: "0", transform: "translateY(50px)"},
    to: %{opacity: "1", transform: "translateY(0)"}
  )

  class(:reveal_card,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_lg}),
    padding: var({Space, :"6"}),
    margin_bottom: var({Space, :"6"}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    # Scroll-driven animation with view()
    animation_name: keyframes(:reveal),
    animation_timeline: "view()",
    animation_range: "entry 0% cover 40%",
    animation_fill_mode: "both"
  )

  class(:card_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_semibold}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"2"})
  )

  class(:card_text,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  # ============================================================================
  # Demo 3: Parallax Effect
  # ============================================================================

  # Parallax: background moves slower than scroll, creating depth
  # Uses small pixel values for subtle effect
  keyframes(:parallax_shift,
    from: %{background_position: "center 100%"},
    to: %{background_position: "center 0%"}
  )

  class(:parallax_container,
    position: "relative",
    height: "400px",
    overflow: "hidden",
    border_radius: const({Tokens, :radius_2xl}),
    margin_bottom: var({Space, :"8"}),
    # Define a named view timeline on the container (the element that enters viewport)
    view_timeline_name: "--parallax-container",
    view_timeline_axis: "block"
  )

  class(:parallax_bg,
    position: "absolute",
    inset: "0",
    # Stripe pattern to make movement visible
    background_color: var({Semantic, :fill_primary}),
    background_image:
      "repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(255,255,255,0.1) 10px, rgba(255,255,255,0.1) 20px)",
    background_size: "100% 200%",
    animation_name: keyframes(:parallax_shift),
    animation_timeline: "--parallax-container",
    animation_fill_mode: "both",
    animation_duration: "1ms"
  )

  class(:parallax_content,
    position: "relative",
    z_index: "1",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    height: "100%",
    color: var({Semantic, :text_on_primary}),
    font_size: const({Tokens, :font_size_3xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    text_shadow: "0 2px 10px #{var({Semantic, :shadow_color_strong})}"
  )

  # ============================================================================
  # Demo 4: Horizontal Scroll Progress
  # ============================================================================

  class(:horizontal_scroll_wrapper,
    width: "100%",
    overflow_x: "auto",
    margin_bottom: var({Space, :"4"}),
    # Define a named scroll timeline for horizontal scrolling
    scroll_timeline_name: "--horizontal-scroll",
    scroll_timeline_axis: "x"
  )

  class(:horizontal_scroll_container,
    display: "flex",
    gap: var({Space, :"4"}),
    padding: var({Space, :"4"}),
    width: "max-content"
  )

  class(:scroll_card,
    flex_shrink: "0",
    width: "280px",
    height: "200px",
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_lg}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    font_size: const({Tokens, :font_size_xl}),
    font_weight: const({Tokens, :font_weight_semibold}),
    color: var({Semantic, :text_primary})
  )

  class(:horizontal_progress,
    position: "sticky",
    left: "0",
    height: "4px",
    background_color: var({Semantic, :fill_muted}),
    border_radius: const({Tokens, :radius_full}),
    overflow: "hidden",
    margin_top: var({Space, :"4"})
  )

  class(:horizontal_progress_bar,
    width: "100%",
    height: "100%",
    background: var({Semantic, :fill_primary}),
    transform_origin: "left",
    animation_name: keyframes(:grow_progress),
    animation_timeline: "--horizontal-scroll",
    animation_timing_function: "linear",
    animation_duration: "1ms"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Scroll-Driven Animations")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="scroll"
      page_title="Scroll-Driven Animations"
      page_subtitle="scroll() + view() timelines, animation-range, pure CSS motion."
    >
      <%!-- Progress bar at top --%>
      <div {css(:progress_bar)}></div>
      <.demo_section>
        <.demo_section_title>Reading Progress</.demo_section_title>
        <.demo_section_description>
          The progress bar at the top tracks your scroll position using <.code_inline>animation-timeline: scroll()</.code_inline>.
        </.demo_section_description>
        <.browser_note>
          <span>⚠️</span>
          <span>Requires Chrome 115+ or browsers with Scroll-Driven Animations support</span>
        </.browser_note>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Parallax Effect</.demo_section_title>
        <.demo_section_description>
          The background moves at a different rate than the scroll using <.code_inline>animation-timeline: view()</.code_inline>.
        </.demo_section_description>
        <div {css(:parallax_container)}>
          <div {css(:parallax_bg)}></div>
          <div {css(:parallax_content)}>
            Parallax Background
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Horizontal Scroll Progress</.demo_section_title>
        <.demo_section_description>
          Scroll horizontally to see the progress bar fill. Uses <.code_inline>animation-timeline: scroll(x nearest)</.code_inline>.
        </.demo_section_description>
        <div {css(:horizontal_scroll_wrapper)}>
          <div {css(:horizontal_scroll_container)}>
            <div :for={i <- 1..8} {css(:scroll_card)}>
              Card {i}
            </div>
          </div>
          <div {css(:horizontal_progress)}>
            <div {css(:horizontal_progress_bar)}></div>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Reveal on Scroll</.demo_section_title>
        <.demo_section_description>
          Cards fade in and slide up as they enter the viewport using
          <.code_inline>animation-timeline: view()</.code_inline>
          and <.code_inline>animation-range</.code_inline>.
        </.demo_section_description>
      </.demo_section>

      <div {css(:scroll_content)}>
        <div :for={i <- 1..6} {css(:reveal_card)}>
          <h3 {css(:card_title)}>Scroll Card {i}</h3>
          <p {css(:card_text)}>
            This card animates into view as you scroll. The animation is driven entirely by
            CSS scroll-driven animations - no JavaScript required!
          </p>
        </div>
      </div>
    </.shell>
    """
  end
end
