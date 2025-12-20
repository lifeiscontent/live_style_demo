defmodule LiveStyleDemoWeb.HomeLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyle.Marker
  alias LiveStyle.When

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Animated Gradient Demo (using typed CSS variables)
  # ============================================================================

  # The CSS variable --anim_angle is typed as <angle> via {:angle, "0deg"}
  # This allows CSS to interpolate the angle value during animation

  # Keyframes that animate the CSS variable itself
  # css_var returns var(--vXXX), which is unwrapped to --vXXX when used as a property name
  css_keyframes(:rotate_gradient,
    from: %{css_var({Tokens, :anim, :angle}) => "0deg"},
    to: %{css_var({Tokens, :anim, :angle}) => "360deg"}
  )

  # ============================================================================
  # Layout Styles
  # ============================================================================

  css_class(:page,
    min_height: "100vh",
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    font_family: css_const({Tokens, :font, :sans}),
    "-webkit-font-smoothing": "antialiased",
    transition: "background-color 0.3s ease"
  )

  css_class(:nav,
    position: "sticky",
    top: "0",
    z_index: "40",
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border_bottom_width: "1px",
    border_bottom_style: "solid",
    border_bottom_color: css_var({Tokens, :semantic, :border_subtle}),
    transition: "background-color 0.3s ease, border-color 0.3s ease"
  )

  css_class(:nav_inner,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"}),
    padding_top: css_const({Tokens, :space, :"4"}),
    padding_bottom: css_const({Tokens, :space, :"4"}),
    display: "flex",
    align_items: "center",
    justify_content: "space-between"
  )

  css_class(:logo,
    display: "flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    text_decoration: "none"
  )

  css_class(:logo_icon,
    width: "2rem",
    height: "2rem",
    background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
    border_radius: css_const({Tokens, :radius, :lg})
  )

  css_class(:animated_gradient,
    width: "12rem",
    height: "12rem",
    border_radius: css_const({Tokens, :radius, :xl}),
    background_image:
      "conic-gradient(from #{css_var({Tokens, :anim, :angle})}, #ffadad, #ffd6a5, #fdffb6, #caffbf, #9bf6ff, #a0c4ff, #bdb2ff, #ffc6ff)",
    animation_name: css_keyframes(:rotate_gradient),
    animation_duration: "10s",
    animation_timing_function: "linear",
    animation_iteration_count: "infinite"
  )

  css_class(:gradient_demo_section,
    padding_top: css_const({Tokens, :space, :"16"}),
    padding_bottom: css_const({Tokens, :space, :"16"}),
    background_color: css_var({Tokens, :semantic, :fill_page})
  )

  css_class(:gradient_demo_inner,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"})
  )

  css_class(:gradient_demo_content,
    display: "flex",
    flex_direction: "column",
    align_items: "center",
    gap: css_const({Tokens, :space, :"8"})
  )

  css_class(:gradient_demo_text,
    text_align: "center",
    max_width: "36rem"
  )

  css_class(:theme_toggle,
    display: "flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    padding_top: css_const({Tokens, :space, :"2"}),
    padding_bottom: css_const({Tokens, :space, :"2"}),
    padding_left: css_const({Tokens, :space, :"3"}),
    padding_right: css_const({Tokens, :space, :"3"}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    border_radius: css_const({Tokens, :radius, :full}),
    border: "none",
    cursor: "pointer",
    transition: "all 0.2s ease",
    background_color: css_var({Tokens, :semantic, :fill_muted})
  )

  # ============================================================================
  # Hero Section
  # ============================================================================

  css_class(:hero,
    padding_top: css_const({Tokens, :space, :"16"}),
    padding_bottom: css_const({Tokens, :space, :"16"}),
    text_align: "center"
  )

  css_class(:hero_inner,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"})
  )

  css_class(:badge,
    display: "inline-flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    padding_top: css_const({Tokens, :space, :"1"}),
    padding_bottom: css_const({Tokens, :space, :"1"}),
    padding_left: css_const({Tokens, :space, :"3"}),
    padding_right: css_const({Tokens, :space, :"3"}),
    background_color: css_var({Tokens, :colors, :indigo_50}),
    color: css_var({Tokens, :colors, :indigo_600}),
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    border_radius: css_const({Tokens, :radius, :full}),
    margin_bottom: css_const({Tokens, :space, :"6"})
  )

  css_class(:hero_title,
    font_size: css_const({Tokens, :font_size, :"3xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    line_height: css_const({Tokens, :leading, :tight}),
    margin_bottom: css_const({Tokens, :space, :"6"})
  )

  css_class(:hero_gradient,
    background: "linear-gradient(135deg, #6366f1 0%, #a855f7 50%, #ec4899 100%)",
    background_clip: "text",
    "-webkit-text-fill-color": "transparent"
  )

  css_class(:hero_subtitle,
    font_size: css_const({Tokens, :font_size, :lg}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    max_width: "42rem",
    margin_left: "auto",
    margin_right: "auto",
    margin_bottom: css_const({Tokens, :space, :"8"}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:hero_buttons,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_const({Tokens, :space, :"4"}),
    justify_content: "center"
  )

  css_class(:btn,
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: css_const({Tokens, :space, :"2"}),
    padding_top: css_const({Tokens, :space, :"3"}),
    padding_bottom: css_const({Tokens, :space, :"3"}),
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"}),
    font_size: css_const({Tokens, :font_size, :base}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    border_radius: css_const({Tokens, :radius, :lg}),
    text_decoration: "none",
    border: "none",
    cursor: "pointer",
    transition: "all 0.2s ease"
  )

  css_class(:btn_primary,
    background: "linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)",
    color: css_var({Tokens, :colors, :white}),
    box_shadow: "0 4px 14px 0 rgba(99, 102, 241, 0.4)"
  )

  css_class(:btn_secondary,
    color: css_var({Tokens, :semantic, :text_primary}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_default}),
    background_color: css_var({Tokens, :semantic, :fill_page})
  )

  # ============================================================================
  # Features Section
  # ============================================================================

  css_class(:features_section,
    padding_top: css_const({Tokens, :space, :"8"}),
    padding_bottom: css_const({Tokens, :space, :"16"}),
    background_color: css_var({Tokens, :semantic, :fill_page})
  )

  css_class(:features_inner,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"})
  )

  css_class(:section_header,
    text_align: "center",
    margin_bottom: css_const({Tokens, :space, :"12"})
  )

  css_class(:section_title,
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    line_height: css_const({Tokens, :leading, :tight}),
    font_size: css_const({Tokens, :font_size, :"2xl"}),
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:section_subtitle,
    font_size: css_const({Tokens, :font_size, :lg}),
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  css_class(:features_grid,
    display: "grid",
    gap: css_const({Tokens, :space, :"8"}),
    grid_template_columns: "repeat(1, 1fr)"
  )

  css_class(:feature_card,
    background_color: css_var({Tokens, :semantic, :fill_card}),
    padding: css_const({Tokens, :space, :"6"}),
    border_radius: css_const({Tokens, :radius, :xl}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    transition: "all 0.2s ease",
    box_shadow: css_const({Tokens, :shadow, :sm})
  )

  # Demo: When selectors - icon transforms when parent card is hovered
  css_class(:feature_icon_transform,
    transform: %{
      :default => "scale(1)",
      When.ancestor(":hover") => "scale(1.15) rotate(5deg)"
    },
    transition: "transform 0.2s ease"
  )

  css_class(:feature_icon,
    display: "flex",
    align_items: "center",
    justify_content: "center",
    width: "3rem",
    height: "3rem",
    border_radius: css_const({Tokens, :radius, :lg}),
    margin_bottom: css_const({Tokens, :space, :"4"}),
    font_size: css_const({Tokens, :font_size, :xl})
  )

  css_class(:feature_icon_purple,
    background_color: css_var({Tokens, :colors, :purple_50}),
    color: css_var({Tokens, :colors, :purple_600})
  )

  css_class(:feature_icon_blue,
    background_color: css_var({Tokens, :colors, :blue_50}),
    color: css_var({Tokens, :colors, :blue_600})
  )

  css_class(:feature_icon_indigo,
    background_color: css_var({Tokens, :colors, :indigo_50}),
    color: css_var({Tokens, :colors, :indigo_600})
  )

  css_class(:feature_icon_green,
    background_color: css_var({Tokens, :colors, :green_50}),
    color: css_var({Tokens, :colors, :green_600})
  )

  css_class(:feature_icon_amber,
    background_color: css_var({Tokens, :colors, :amber_50}),
    color: css_var({Tokens, :colors, :amber_600})
  )

  css_class(:feature_icon_red,
    background_color: css_var({Tokens, :colors, :red_50}),
    color: css_var({Tokens, :colors, :red_600})
  )

  css_class(:feature_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:feature_text,
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  # ============================================================================
  # Code Example Section
  # ============================================================================

  css_class(:code_section,
    padding_top: css_const({Tokens, :space, :"16"}),
    padding_bottom: css_const({Tokens, :space, :"16"}),
    background_color: css_var({Tokens, :semantic, :fill_surface})
  )

  css_class(:code_inner,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"})
  )

  css_class(:code_block,
    background_color: css_var({Tokens, :colors, :gray_900}),
    border_radius: css_const({Tokens, :radius, :xl}),
    padding: css_const({Tokens, :space, :"6"}),
    overflow_x: "auto"
  )

  css_class(:code_header,
    display: "flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  css_class(:code_dot,
    width: "0.75rem",
    height: "0.75rem",
    border_radius: css_const({Tokens, :radius, :full})
  )

  css_class(:code_dot_red,
    background_color: "#ff5f57"
  )

  css_class(:code_dot_yellow,
    background_color: "#febc2e"
  )

  css_class(:code_dot_green,
    background_color: "#28c840"
  )

  css_class(:code_pre,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :colors, :gray_100}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    margin: "0",
    white_space: "pre-wrap"
  )

  css_class(:code_keyword,
    color: "#c084fc"
  )

  css_class(:code_function,
    color: "#60a5fa"
  )

  css_class(:code_string,
    color: "#86efac"
  )

  css_class(:code_comment,
    color: "#6b7280"
  )

  css_class(:code_atom,
    color: "#fbbf24"
  )

  # ============================================================================
  # Anchor Positioning Demo (@position-try)
  # ============================================================================

  css_class(:anchor_demo_section,
    padding_top: css_const({Tokens, :space, :"16"}),
    padding_bottom: css_const({Tokens, :space, :"16"}),
    background_color: css_var({Tokens, :semantic, :fill_surface})
  )

  css_class(:anchor_demo_inner,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"})
  )

  css_class(:anchor_demo_content,
    display: "flex",
    flex_direction: "column",
    align_items: "center",
    gap: css_const({Tokens, :space, :"8"})
  )

  css_class(:anchor_demo_container,
    display: "flex",
    justify_content: "center",
    align_items: "center",
    min_height: "200px",
    width: "100%"
  )

  # The anchor element (button that the tooltip is anchored to)
  css_class(:anchor_button,
    anchor_name: "--demo-anchor",
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: css_const({Tokens, :space, :"2"}),
    padding_top: css_const({Tokens, :space, :"3"}),
    padding_bottom: css_const({Tokens, :space, :"3"}),
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"}),
    font_size: css_const({Tokens, :font_size, :base}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :colors, :white}),
    background: "linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)",
    border: "none",
    border_radius: css_const({Tokens, :radius, :lg}),
    cursor: "pointer",
    box_shadow: "0 4px 14px 0 rgba(99, 102, 241, 0.4)"
  )

  # The positioned tooltip element with inline @position-try fallbacks
  # Hidden by default, shown when button is hovered
  # Note: @position-try only allows positioning/sizing properties (not transform/translate)
  css_class(:anchor_tooltip,
    # Fixed positioning relative to viewport, anchored to the button
    position: "fixed",
    position_anchor: "--demo-anchor",
    # Default position: below the anchor, centered using position-area
    position_area: "bottom center",
    margin: "8px",
    # Fallback positions using position-area values directly
    position_try_fallbacks: "flip-block",
    # Hidden by default, shown on hover via sibling selector
    opacity: %{
      :default => "0",
      When.sibling_before(":hover") => "1"
    },
    pointer_events: %{
      :default => "none",
      When.sibling_before(":hover") => "auto"
    },
    transition: "opacity 0.15s ease",
    # Styling
    width: "max-content",
    text_align: "center",
    padding_top: css_const({Tokens, :space, :"2"}),
    padding_bottom: css_const({Tokens, :space, :"2"}),
    padding_left: css_const({Tokens, :space, :"3"}),
    padding_right: css_const({Tokens, :space, :"3"}),
    background_color: css_var({Tokens, :colors, :gray_900}),
    color: css_var({Tokens, :colors, :white}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    z_index: "50"
  )

  css_class(:anchor_note,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_muted}),
    text_align: "center",
    max_width: "32rem"
  )

  # ============================================================================
  # Footer
  # ============================================================================

  css_class(:footer,
    padding_top: css_const({Tokens, :space, :"8"}),
    padding_bottom: css_const({Tokens, :space, :"8"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border_top_width: "1px",
    border_top_style: "solid",
    border_top_color: css_var({Tokens, :semantic, :border_subtle})
  )

  css_class(:footer_inner,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_const({Tokens, :space, :"6"}),
    padding_right: css_const({Tokens, :space, :"6"}),
    text_align: "center"
  )

  css_class(:footer_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:footer_link,
    color: css_var({Tokens, :semantic, :text_link}),
    text_decoration: "none"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  # Dynamic style rule - opacity can be set at runtime
  # CSS is generated with var(--x-opacity), runtime sets the variable value
  css_class(:dynamic_opacity, fn opacity -> [opacity: opacity] end)

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Home", dark_mode: false, gradient_opacity: "1")
     |> push_event("start-view-transition", %{type: "page"}, dispatch: :before)}
  end

  defp code_example do
    """
    defmodule MyApp.Button do
      use Phoenix.Component
      use LiveStyle

      # Define a named style with keyword list syntax
      css_class :base,
        display: "inline-flex",
        padding: "8px 16px",
        border_radius: css_const({Tokens, :radius, :md})

      css_class :primary,
        background_color: css_var({Tokens, :semantic, :fill_primary}),
        color: css_var({Tokens, :semantic, :text_inverse})

      def button(assigns) do
        ~H\"\"\"
        <button class={css_class([:base, :primary])}>
          {render_slot(@inner_block)}
        </button>
        \"\"\"
      end
    end
    """
  end

  @impl true
  def handle_event("toggle_theme", _params, socket) do
    {:noreply, assign(socket, dark_mode: !socket.assigns.dark_mode)}
  end

  @impl true
  def handle_event("update_opacity", %{"opacity" => opacity}, socket) do
    {:noreply, assign(socket, gradient_opacity: opacity)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class={theme_classes(@dark_mode, css_class([:page]))}>
      <%!-- Navigation --%>
      <nav class={css_class([:nav])}>
        <div class={css_class([:nav_inner])}>
          <a href="/" class={css_class([:logo])}>
            <div class={css_class([:logo_icon])}></div>
            <span>LiveStyle</span>
          </a>
          <button phx-click="toggle_theme" class={css_class([:theme_toggle])}>
            <span :if={@dark_mode}>&#9728;&#65039; Light</span>
            <span :if={!@dark_mode}>&#9789;&#65039; Dark</span>
          </button>
        </div>
      </nav>

      <%!-- Hero Section --%>
      <section class={css_class([:hero])}>
        <div class={css_class([:hero_inner])}>
          <div class={css_class([:badge])}>
            <span>&#9889;</span>
            <span>Compile-time CSS for Phoenix</span>
          </div>
          <h1 class={css_class([:hero_title])}>
            Style your LiveView apps <br />
            <span class={css_class([:hero_gradient])}>with zero runtime cost</span>
          </h1>
          <p class={css_class([:hero_subtitle])}>
            LiveStyle brings the power of StyleX to Elixir. Define your styles with atomic CSS, design tokens, and themes - all resolved at compile time.
          </p>
          <div class={css_class([:hero_buttons])}>
            <.link navigate="/todo" class={css_class([:btn, :btn_primary])}>
              <span>&#9745;</span> Todo Demo
            </.link>
            <.link navigate="/table" class={css_class([:btn, :btn_secondary])}>
              <span>&#128200;</span> Table Demo
            </.link>
          </div>
        </div>
      </section>

      <%!-- Features Section --%>
      <section class={css_class([:features_section])}>
        <div class={css_class([:features_inner])}>
          <div class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Why LiveStyle?</h2>
            <p class={css_class([:section_subtitle])}>
              Everything you need to build beautiful, maintainable UIs
            </p>
          </div>
          <div class={css_class([:features_grid])}>
            <div class={"#{css_class([:feature_card])} #{Marker.default()}"}>
              <div class={css_class([:feature_icon, :feature_icon_purple, :feature_icon_transform])}>
                &#9889;
              </div>
              <h3 class={css_class([:feature_title])}>Zero Runtime</h3>
              <p class={css_class([:feature_text])}>
                All styles are resolved at compile time. No runtime style generation, no JavaScript bundle, just static CSS.
              </p>
            </div>
            <div class={"#{css_class([:feature_card])} #{Marker.default()}"}>
              <div class={css_class([:feature_icon, :feature_icon_blue, :feature_icon_transform])}>
                &#127912;
              </div>
              <h3 class={css_class([:feature_title])}>Design Tokens</h3>
              <p class={css_class([:feature_text])}>
                Define your design system with typed tokens using css_vars. Colors, spacing, typography - all in one place.
              </p>
            </div>
            <div class={"#{css_class([:feature_card])} #{Marker.default()}"}>
              <div class={css_class([:feature_icon, :feature_icon_indigo, :feature_icon_transform])}>
                &#127752;
              </div>
              <h3 class={css_class([:feature_title])}>Theming</h3>
              <p class={css_class([:feature_text])}>
                Create themes with css_theme to override CSS variables for any subtree. Dark mode? Easy.
              </p>
            </div>
            <div class={"#{css_class([:feature_card])} #{Marker.default()}"}>
              <div class={css_class([:feature_icon, :feature_icon_green, :feature_icon_transform])}>
                &#9999;&#65039;
              </div>
              <h3 class={css_class([:feature_title])}>Atomic CSS</h3>
              <p class={css_class([:feature_text])}>
                Each style property generates a unique class. Compose styles with predictable, collision-free results.
              </p>
            </div>
            <div class={"#{css_class([:feature_card])} #{Marker.default()}"}>
              <div class={css_class([:feature_icon, :feature_icon_amber, :feature_icon_transform])}>
                &#128268;
              </div>
              <h3 class={css_class([:feature_title])}>Responsive</h3>
              <p class={css_class([:feature_text])}>
                Built-in support for media queries with the condition-in-property pattern. No breakpoint gymnastics.
              </p>
            </div>
            <div class={"#{css_class([:feature_card])} #{Marker.default()}"}>
              <div class={css_class([:feature_icon, :feature_icon_red, :feature_icon_transform])}>
                &#10084;&#65039;
              </div>
              <h3 class={css_class([:feature_title])}>Phoenix Native</h3>
              <p class={css_class([:feature_text])}>
                Designed for Phoenix LiveView from the ground up. Integrates seamlessly with components and HEEx.
              </p>
            </div>
          </div>
        </div>
      </section>

      <%!-- Animated Gradient Demo --%>
      <section class={css_class([:gradient_demo_section])}>
        <div class={css_class([:gradient_demo_inner])}>
          <div class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Typed CSS Variables</h2>
            <p class={css_class([:section_subtitle])}>Animate the impossible with @property</p>
          </div>
          <div class={css_class([:gradient_demo_content])}>
            <%!-- Using css/1 with spreading for dynamic opacity style --%>
            <div {css([:animated_gradient, {:dynamic_opacity, @gradient_opacity}])}></div>
            <div class={css_class([:gradient_demo_text])}>
              <p class={css_class([:feature_text])}>
                This gradient is animated by changing a CSS custom property.
                LiveStyle's <code>angle</code> type generates a CSS <code>@property</code> rule,
                enabling the browser to interpolate angle values smoothly.
              </p>
              <form phx-change="update_opacity" style="margin-top: 1rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-size: 0.875rem;">
                  Opacity: {@gradient_opacity}
                </label>
                <input
                  type="range"
                  min="0"
                  max="1"
                  step="0.1"
                  value={@gradient_opacity}
                  name="opacity"
                  style="width: 100%;"
                />
              </form>
            </div>
          </div>
        </div>
      </section>

      <%!-- Anchor Positioning Demo --%>
      <section class={css_class([:anchor_demo_section])}>
        <div class={css_class([:anchor_demo_inner])}>
          <div class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>CSS Anchor Positioning</h2>
            <p class={css_class([:section_subtitle])}>Smart tooltips with @position-try fallbacks</p>
          </div>
          <div class={css_class([:anchor_demo_content])}>
            <div class={css_class([:anchor_demo_container])}>
              <button class={"#{css_class([:anchor_button])} #{Marker.default()}"}>
                &#128205; Hover me
              </button>
              <div class={css_class([:anchor_tooltip])}>
                I'm anchored! Try resizing the window.
              </div>
            </div>
            <p class={css_class([:anchor_note])}>
              This tooltip uses CSS Anchor Positioning with <code>@position-try</code>
              fallbacks.
              When the preferred position doesn't fit, the browser automatically tries alternative positions.
              <br /><br />
              <strong>Note:</strong>
              Requires Chrome 125+ or other browsers with anchor positioning support.
            </p>
          </div>
        </div>
      </section>

      <%!-- Code Example Section --%>
      <section class={css_class([:code_section])}>
        <div class={css_class([:code_inner])}>
          <div class={css_class([:section_header])}>
            <h2 class={css_class([:section_title])}>Simple, Declarative API</h2>
            <p class={css_class([:section_subtitle])}>
              Familiar patterns that feel right at home in Elixir
            </p>
          </div>
          <div class={css_class([:code_block])}>
            <div class={css_class([:code_header])}>
              <div class={css_class([:code_dot, :code_dot_red])}></div>
              <div class={css_class([:code_dot, :code_dot_yellow])}></div>
              <div class={css_class([:code_dot, :code_dot_green])}></div>
            </div>
            <pre class={css_class([:code_pre])}>{code_example()}</pre>
          </div>
        </div>
      </section>

      <%!-- Footer --%>
      <footer class={css_class([:footer])}>
        <div class={css_class([:footer_inner])}>
          <p class={css_class([:footer_text])}>
            Built with
            <a href="https://phoenixframework.org" class={css_class([:footer_link])}>Phoenix</a>
            and <a href="https://github.com" class={css_class([:footer_link])}>LiveStyle</a>.
            Inspired by <a href="https://stylexjs.com" class={css_class([:footer_link])}>StyleX</a>.
          </p>
        </div>
      </footer>
    </div>
    """
  end

  defp theme_classes(dark_mode, base_classes) do
    if dark_mode do
      "#{base_classes} #{css_theme({Tokens, :semantic, :dark})} #{css_theme({Tokens, :semantic, :dark})} #{css_theme({Tokens, :semantic, :dark})}"
    else
      base_classes
    end
  end
end
