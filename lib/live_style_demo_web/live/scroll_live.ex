defmodule LiveStyleDemoWeb.ScrollLive do
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
    position: "fixed",
    top: "0",
    left: "0",
    right: "0",
    padding: css_const({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border_bottom: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    z_index: "100"
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
    padding_top: "80px"
  )

  css_class(:section,
    width: "100%",
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding: css_const({Tokens, :space, :"8"})
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
  # Demo 1: Reading Progress Bar
  # ============================================================================

  css_keyframes(:grow_progress,
    from: %{transform: "scaleX(0)"},
    to: %{transform: "scaleX(1)"}
  )

  css_class(:progress_bar,
    position: "fixed",
    top: "0",
    left: "0",
    width: "100%",
    height: "4px",
    background: "linear-gradient(90deg, #4f46e5, #7c3aed)",
    transform_origin: "left",
    z_index: "200",
    # Scroll-driven animation
    animation_name: css_keyframes(:grow_progress),
    animation_timeline: "scroll()",
    animation_timing_function: "linear"
  )

  # ============================================================================
  # Demo 2: Reveal on Scroll
  # ============================================================================

  css_class(:scroll_content,
    min_height: "150vh",
    padding: css_const({Tokens, :space, :"8"})
  )

  css_keyframes(:reveal,
    from: %{opacity: "0", transform: "translateY(50px)"},
    to: %{opacity: "1", transform: "translateY(0)"}
  )

  css_class(:reveal_card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"6"}),
    margin_bottom: css_const({Tokens, :space, :"6"}),
    # Scroll-driven animation with view()
    animation_name: css_keyframes(:reveal),
    animation_timeline: "view()",
    animation_range: "entry 0% cover 40%",
    animation_fill_mode: "both"
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:card_text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  # ============================================================================
  # Demo 3: Parallax Effect
  # ============================================================================

  # Parallax: background moves slower than scroll, creating depth
  # Uses small pixel values for subtle effect
  css_keyframes(:parallax_shift,
    from: %{background_position: "center 100%"},
    to: %{background_position: "center 0%"}
  )

  css_class(:parallax_container,
    position: "relative",
    height: "400px",
    overflow: "hidden",
    border_radius: css_const({Tokens, :radius, :lg}),
    margin_bottom: css_const({Tokens, :space, :"8"}),
    # Define a named view timeline on the container (the element that enters viewport)
    view_timeline_name: "--parallax-container",
    view_timeline_axis: "block"
  )

  css_class(:parallax_bg,
    position: "absolute",
    inset: "0",
    # Use background-size to make the gradient taller than container
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 50%, #667eea 100%)",
    background_size: "100% 200%",
    animation_name: css_keyframes(:parallax_shift),
    animation_timeline: "--parallax-container",
    animation_fill_mode: "both",
    animation_duration: "1ms"
  )

  css_class(:parallax_content,
    position: "relative",
    z_index: "1",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    height: "100%",
    color: css_var({Tokens, :colors, :white}),
    font_size: css_const({Tokens, :font_size, :"3xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    text_shadow: "0 2px 10px rgba(0,0,0,0.3)"
  )

  # ============================================================================
  # Demo 4: Horizontal Scroll Progress
  # ============================================================================

  css_class(:horizontal_scroll_wrapper,
    width: "100%",
    overflow_x: "auto",
    margin_bottom: css_const({Tokens, :space, :"4"}),
    # Define a named scroll timeline for horizontal scrolling
    scroll_timeline_name: "--horizontal-scroll",
    scroll_timeline_axis: "x"
  )

  css_class(:horizontal_scroll_container,
    display: "flex",
    gap: css_const({Tokens, :space, :"4"}),
    padding: css_const({Tokens, :space, :"4"}),
    width: "max-content"
  )

  css_class(:scroll_card,
    flex_shrink: "0",
    width: "280px",
    height: "200px",
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    display: "flex",
    align_items: "center",
    justify_content: "center",
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:horizontal_progress,
    position: "sticky",
    left: "0",
    height: "4px",
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border_radius: css_const({Tokens, :radius, :full}),
    overflow: "hidden",
    margin_top: css_const({Tokens, :space, :"4"})
  )

  css_class(:horizontal_progress_bar,
    width: "100%",
    height: "100%",
    background: "linear-gradient(90deg, #10b981, #059669)",
    transform_origin: "left",
    animation_name: css_keyframes(:grow_progress),
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
    <div class={css_class([:page])}>
      <%!-- Progress bar at top --%>
      <div class={css_class([:progress_bar])}></div>

      <header class={css_class([:header])}>
        <div class={css_class([:header_inner])}>
          <.link navigate="/" class={css_class([:back_link])}>
            ← Back to Home
          </.link>
          <h1 class={css_class([:page_title])}>Scroll-Driven Animations</h1>
          <div></div>
        </div>
      </header>

      <main class={css_class([:main])}>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Reading Progress</h2>
          <p class={css_class([:section_description])}>
            The purple bar at the top shows your scroll progress through the page using <code class={
              css_class([:code_inline])
            }>animation-timeline: scroll()</code>.
          </p>
          <div class={css_class([:browser_note])}>
            <span>⚠️</span>
            <span>Requires Chrome 115+ or browsers with Scroll-Driven Animations support</span>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Parallax Effect</h2>
          <p class={css_class([:section_description])}>
            The background moves at a different rate than the scroll using <code class={
              css_class([:code_inline])
            }>animation-timeline: view()</code>.
          </p>
          <div class={css_class([:parallax_container])}>
            <div class={css_class([:parallax_bg])}></div>
            <div class={css_class([:parallax_content])}>
              Parallax Background
            </div>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Horizontal Scroll Progress</h2>
          <p class={css_class([:section_description])}>
            Scroll horizontally to see the progress bar fill. Uses <code class={
              css_class([:code_inline])
            }>animation-timeline: scroll(x nearest)</code>.
          </p>
          <div class={css_class([:horizontal_scroll_wrapper])}>
            <div class={css_class([:horizontal_scroll_container])}>
              <div :for={i <- 1..8} class={css_class([:scroll_card])}>
                Card {i}
              </div>
            </div>
            <div class={css_class([:horizontal_progress])}>
              <div class={css_class([:horizontal_progress_bar])}></div>
            </div>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Reveal on Scroll</h2>
          <p class={css_class([:section_description])}>
            Cards fade in and slide up as they enter the viewport using
            <code class={css_class([:code_inline])}>animation-timeline: view()</code>
            and <code class={css_class([:code_inline])}>animation-range</code>.
          </p>
        </section>

        <div class={css_class([:scroll_content])}>
          <div :for={i <- 1..6} class={css_class([:reveal_card])}>
            <h3 class={css_class([:card_title])}>Scroll Card {i}</h3>
            <p class={css_class([:card_text])}>
              This card animates into view as you scroll. The animation is driven entirely by
              CSS scroll-driven animations - no JavaScript required!
            </p>
          </div>
        </div>
      </main>
    </div>
    """
  end
end
