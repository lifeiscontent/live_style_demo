defmodule LiveStyleDemoWeb.HomeLive do
  use LiveStyleDemoWeb, :live_view
  use LiveStyle

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.BaseStyles

  # ============================================================================
  # Layout Styles
  # ============================================================================

  style(:page,
    min_height: "100vh",
    background_color: var(:fill_surface),
    font_family: var(:font_sans),
    "-webkit-font-smoothing": "antialiased",
    transition: "background-color 0.3s ease"
  )

  style(:nav,
    position: first_that_works(["sticky", "-webkit-sticky", "fixed"]),
    top: "0",
    z_index: "40",
    background_color: var(:fill_page),
    border_bottom_width: "1px",
    border_bottom_style: "solid",
    border_bottom_color: var(:border_subtle),
    transition: "background-color 0.3s ease, border-color 0.3s ease"
  )

  # Using __include__ to compose from BaseStyles.container and BaseStyles.flex_between
  style(:nav_inner,
    __include__: [{BaseStyles, :container}, {BaseStyles, :flex_between}],
    padding_top: var(:space_4),
    padding_bottom: var(:space_4)
  )

  style(:logo,
    display: "flex",
    align_items: "center",
    gap: var(:space_2),
    font_size: var(:text_size_xl),
    font_weight: var(:font_weight_bold),
    color: var(:text_primary),
    text_decoration: "none"
  )

  style(:logo_icon,
    width: "2rem",
    height: "2rem",
    background: "linear-gradient(135deg, #6366f1 0%, #a855f7 100%)",
    border_radius: var(:radius_lg)
  )

  # ============================================================================
  # Animated Gradient Demo (using typed CSS variables)
  # ============================================================================

  # The CSS variable --anim_angle is typed as <angle> via LiveStyle.Types.angle()
  # This allows CSS to interpolate the angle value during animation

  # Keyframes that animate the CSS variable itself
  keyframes(:rotate_gradient,
    from: %{var(:anim_angle) => "0deg"},
    to: %{var(:anim_angle) => "360deg"}
  )

  style(:animated_gradient,
    width: "12rem",
    height: "12rem",
    border_radius: var(:radius_xl),
    background_image:
      "conic-gradient(from #{var(:anim_angle)}, #ffadad, #ffd6a5, #fdffb6, #caffbf, #9bf6ff, #a0c4ff, #bdb2ff, #ffc6ff)",
    animation_name: :rotate_gradient,
    animation_duration: "10s",
    animation_timing_function: "linear",
    animation_iteration_count: "infinite"
  )

  style(:gradient_demo_section,
    padding_top: var(:space_16),
    padding_bottom: var(:space_16),
    background_color: var(:fill_page)
  )

  # Using __include__ to compose from BaseStyles.container_narrow
  style(:gradient_demo_inner,
    __include__: [{BaseStyles, :container_narrow}]
  )

  # Using __include__ to compose from BaseStyles.flex_col
  style(:gradient_demo_content,
    __include__: [{BaseStyles, :flex_col}],
    align_items: "center",
    gap: var(:space_8)
  )

  style(:gradient_demo_text,
    text_align: "center",
    max_width: "36rem"
  )

  style(:theme_toggle,
    display: "flex",
    align_items: "center",
    gap: var(:space_2),
    padding_top: var(:space_2),
    padding_bottom: var(:space_2),
    padding_left: var(:space_3),
    padding_right: var(:space_3),
    color: var(:text_secondary),
    font_size: var(:text_size_sm),
    font_weight: var(:font_weight_medium),
    border_radius: var(:radius_full),
    border: "none",
    cursor: "pointer",
    transition: "all 0.2s ease",
    background_color: [
      default: var(:fill_muted),
      ":hover": var(:fill_secondary_hover)
    ]
  )

  # ============================================================================
  # Hero Section
  # ============================================================================

  # Using __include__ to compose from BaseStyles.section
  style(:hero,
    __include__: [{BaseStyles, :section}],
    text_align: "center"
  )

  # Using __include__ to compose from BaseStyles.container_narrow
  style(:hero_inner,
    __include__: [{BaseStyles, :container_narrow}]
  )

  style(:badge,
    display: "inline-flex",
    align_items: "center",
    gap: var(:space_2),
    padding_top: var(:space_1),
    padding_bottom: var(:space_1),
    padding_left: var(:space_3),
    padding_right: var(:space_3),
    background_color: var(:color_indigo_50),
    color: var(:color_indigo_600),
    font_size: var(:text_size_sm),
    font_weight: var(:font_weight_medium),
    border_radius: var(:radius_full),
    margin_bottom: var(:space_6)
  )

  style(:hero_title,
    font_size: [
      {:default, var(:text_size_3xl)},
      {Tokens.breakpoints_lg(), var(:text_size_5xl)}
    ],
    font_weight: var(:font_weight_bold),
    color: var(:text_primary),
    line_height: var(:leading_tight),
    margin_bottom: var(:space_6)
  )

  style(:hero_gradient,
    background: "linear-gradient(135deg, #6366f1 0%, #a855f7 50%, #ec4899 100%)",
    "-webkit-background-clip": "text",
    "-webkit-text-fill-color": "transparent",
    background_clip: "text"
  )

  style(:hero_subtitle,
    font_size: [
      {:default, var(:text_size_lg)},
      {Tokens.breakpoints_lg(), var(:text_size_xl)}
    ],
    color: var(:text_secondary),
    max_width: "42rem",
    margin_left: "auto",
    margin_right: "auto",
    margin_bottom: var(:space_8),
    line_height: var(:leading_relaxed)
  )

  style(:hero_buttons,
    display: "flex",
    flex_wrap: "wrap",
    gap: var(:space_4),
    justify_content: "center"
  )

  # Using __include__ to compose from BaseStyles.btn_base
  style(:btn,
    __include__: [{BaseStyles, :btn_base}]
  )

  style(:btn_primary,
    background: "linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)",
    color: var(:color_white),
    box_shadow: "0 4px 14px 0 rgba(99, 102, 241, 0.4)",
    opacity: [
      default: "1",
      ":hover": "0.9"
    ]
  )

  style(:btn_secondary,
    color: var(:text_primary),
    border_width: "1px",
    border_style: "solid",
    border_color: var(:border_default),
    background_color: [
      default: var(:fill_page),
      ":hover": var(:fill_muted)
    ]
  )

  # ============================================================================
  # Features Section
  # ============================================================================

  style(:features_section,
    padding_top: var(:space_8),
    padding_bottom: var(:space_16),
    background_color: var(:fill_page)
  )

  # Using __include__ to compose from BaseStyles.container
  style(:features_inner,
    __include__: [{BaseStyles, :container}]
  )

  style(:section_header,
    text_align: "center",
    margin_bottom: var(:space_12)
  )

  # Using __include__ to compose from BaseStyles.heading
  style(:section_title,
    __include__: [{BaseStyles, :heading}],
    font_size: var(:text_size_2xl),
    margin_bottom: var(:space_2)
  )

  style(:section_subtitle,
    font_size: var(:text_size_lg),
    color: var(:text_secondary)
  )

  style(:features_grid,
    display: "grid",
    gap: var(:space_8),
    grid_template_columns: [
      {:default, "1fr"},
      {Tokens.breakpoints_md(), "repeat(2, 1fr)"},
      {Tokens.breakpoints_lg(), "repeat(3, 1fr)"}
    ]
  )

  # Using __include__ to compose from BaseStyles.card_base
  style(:feature_card,
    __include__: [{BaseStyles, :card_base}],
    box_shadow: [
      default: var(:shadow_sm),
      ":hover": var(:shadow_md)
    ]
  )

  # Using __include__ to compose from BaseStyles.flex_center
  style(:feature_icon,
    __include__: [{BaseStyles, :flex_center}],
    width: "3rem",
    height: "3rem",
    border_radius: var(:radius_lg),
    margin_bottom: var(:space_4),
    font_size: var(:text_size_xl)
  )

  style(:feature_icon_purple,
    background_color: var(:color_purple_50),
    color: var(:color_purple_600)
  )

  style(:feature_icon_blue,
    background_color: var(:color_blue_50),
    color: var(:color_blue_600)
  )

  style(:feature_icon_indigo,
    background_color: var(:color_indigo_50),
    color: var(:color_indigo_600)
  )

  style(:feature_icon_green,
    background_color: var(:color_green_50),
    color: var(:color_green_600)
  )

  style(:feature_icon_amber,
    background_color: var(:color_amber_50),
    color: var(:color_amber_600)
  )

  style(:feature_icon_red,
    background_color: var(:color_red_50),
    color: var(:color_red_600)
  )

  style(:feature_title,
    font_size: var(:text_size_lg),
    font_weight: var(:font_weight_semibold),
    color: var(:text_primary),
    margin_bottom: var(:space_2)
  )

  style(:feature_text,
    font_size: var(:text_size_base),
    color: var(:text_secondary),
    line_height: var(:leading_relaxed)
  )

  # ============================================================================
  # Code Example Section
  # ============================================================================

  style(:code_section,
    padding_top: var(:space_16),
    padding_bottom: var(:space_16),
    background_color: var(:fill_surface)
  )

  style(:code_inner,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: var(:space_6),
    padding_right: var(:space_6)
  )

  style(:code_block,
    background_color: var(:color_gray_900),
    border_radius: var(:radius_xl),
    padding: var(:space_6),
    overflow_x: "auto"
  )

  style(:code_header,
    display: "flex",
    align_items: "center",
    gap: var(:space_2),
    margin_bottom: var(:space_4)
  )

  style(:code_dot,
    width: "0.75rem",
    height: "0.75rem",
    border_radius: var(:radius_full)
  )

  style(:code_dot_red,
    background_color: "#ff5f57"
  )

  style(:code_dot_yellow,
    background_color: "#febc2e"
  )

  style(:code_dot_green,
    background_color: "#28c840"
  )

  style(:code_pre,
    font_family: var(:font_mono),
    font_size: var(:text_size_sm),
    color: var(:color_gray_100),
    line_height: var(:leading_relaxed),
    margin: "0",
    white_space: "pre-wrap"
  )

  style(:code_keyword,
    color: "#c084fc"
  )

  style(:code_function,
    color: "#60a5fa"
  )

  style(:code_string,
    color: "#86efac"
  )

  style(:code_comment,
    color: "#6b7280"
  )

  style(:code_atom,
    color: "#fbbf24"
  )

  # ============================================================================
  # Footer
  # ============================================================================

  style(:footer,
    padding_top: var(:space_8),
    padding_bottom: var(:space_8),
    background_color: var(:fill_page),
    border_top_width: "1px",
    border_top_style: "solid",
    border_top_color: var(:border_subtle)
  )

  style(:footer_inner,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: var(:space_6),
    padding_right: var(:space_6),
    text_align: "center"
  )

  style(:footer_text,
    font_size: var(:text_size_sm),
    color: var(:text_muted)
  )

  style(:footer_link,
    color: var(:text_link),
    text_decoration: [
      default: "none",
      ":hover": "underline"
    ]
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Home", dark_mode: false)
     |> push_event("start-view-transition", %{type: "page"}, dispatch: :before)}
  end

  defp code_example do
    """
    defmodule MyApp.Button do
      use Phoenix.Component
      use LiveStyle

      # Define a named style with keyword list syntax
      style :base,
        display: "inline-flex",
        padding: "8px 16px",
        border_radius: var(:radius_md)

      style :primary,
        background_color: var(:fill_primary),
        color: var(:text_inverse)

      def button(assigns) do
        ~H\"\"\"
        <button class={style([:base, :primary])}>
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
  def render(assigns) do
    ~H"""
    <div class={theme_classes(@dark_mode, style([:page]))}>
      <%!-- Navigation --%>
      <nav class={style([:nav])}>
        <div class={style([:nav_inner])}>
          <a href="/" class={style([:logo])}>
            <div class={style([:logo_icon])}></div>
            <span>LiveStyle</span>
          </a>
          <button phx-click="toggle_theme" class={style([:theme_toggle])}>
            <span :if={@dark_mode}>&#9728;&#65039; Light</span>
            <span :if={!@dark_mode}>&#9789;&#65039; Dark</span>
          </button>
        </div>
      </nav>

      <%!-- Hero Section --%>
      <section class={style([:hero])}>
        <div class={style([:hero_inner])}>
          <div class={style([:badge])}>
            <span>&#9889;</span>
            <span>Compile-time CSS for Phoenix</span>
          </div>
          <h1 class={style([:hero_title])}>
            Style your LiveView apps <br />
            <span class={style([:hero_gradient])}>with zero runtime cost</span>
          </h1>
          <p class={style([:hero_subtitle])}>
            LiveStyle brings the power of StyleX to Elixir. Define your styles with atomic CSS, design tokens, and themes - all resolved at compile time.
          </p>
          <div class={style([:hero_buttons])}>
            <.link navigate="/todo" class={style([:btn, :btn_primary])}>
              <span>&#9745;</span> Todo Demo
            </.link>
            <.link navigate="/table" class={style([:btn, :btn_secondary])}>
              <span>&#128200;</span> Table Demo
            </.link>
          </div>
        </div>
      </section>

      <%!-- Features Section --%>
      <section class={style([:features_section])}>
        <div class={style([:features_inner])}>
          <div class={style([:section_header])}>
            <h2 class={style([:section_title])}>Why LiveStyle?</h2>
            <p class={style([:section_subtitle])}>
              Everything you need to build beautiful, maintainable UIs
            </p>
          </div>
          <div class={style([:features_grid])}>
            <div class={style([:feature_card])}>
              <div class={style([:feature_icon, :feature_icon_purple])}>&#9889;</div>
              <h3 class={style([:feature_title])}>Zero Runtime</h3>
              <p class={style([:feature_text])}>
                All styles are resolved at compile time. No runtime style generation, no JavaScript bundle, just static CSS.
              </p>
            </div>
            <div class={style([:feature_card])}>
              <div class={style([:feature_icon, :feature_icon_blue])}>&#127912;</div>
              <h3 class={style([:feature_title])}>Design Tokens</h3>
              <p class={style([:feature_text])}>
                Define your design system with typed tokens using defvars. Colors, spacing, typography - all in one place.
              </p>
            </div>
            <div class={style([:feature_card])}>
              <div class={style([:feature_icon, :feature_icon_indigo])}>&#127752;</div>
              <h3 class={style([:feature_title])}>Theming</h3>
              <p class={style([:feature_text])}>
                Create themes with create_theme to override CSS variables for any subtree. Dark mode? Easy.
              </p>
            </div>
            <div class={style([:feature_card])}>
              <div class={style([:feature_icon, :feature_icon_green])}>&#9999;&#65039;</div>
              <h3 class={style([:feature_title])}>Atomic CSS</h3>
              <p class={style([:feature_text])}>
                Each style property generates a unique class. Compose styles with predictable, collision-free results.
              </p>
            </div>
            <div class={style([:feature_card])}>
              <div class={style([:feature_icon, :feature_icon_amber])}>&#128268;</div>
              <h3 class={style([:feature_title])}>Responsive</h3>
              <p class={style([:feature_text])}>
                Built-in support for media queries with the condition-in-property pattern. No breakpoint gymnastics.
              </p>
            </div>
            <div class={style([:feature_card])}>
              <div class={style([:feature_icon, :feature_icon_red])}>&#10084;&#65039;</div>
              <h3 class={style([:feature_title])}>Phoenix Native</h3>
              <p class={style([:feature_text])}>
                Designed for Phoenix LiveView from the ground up. Integrates seamlessly with components and HEEx.
              </p>
            </div>
          </div>
        </div>
      </section>

      <%!-- Animated Gradient Demo --%>
      <section class={style([:gradient_demo_section])}>
        <div class={style([:gradient_demo_inner])}>
          <div class={style([:section_header])}>
            <h2 class={style([:section_title])}>Typed CSS Variables</h2>
            <p class={style([:section_subtitle])}>Animate the impossible with @property</p>
          </div>
          <div class={style([:gradient_demo_content])}>
            <div class={style([:animated_gradient])}></div>
            <div class={style([:gradient_demo_text])}>
              <p class={style([:feature_text])}>
                This gradient is animated by changing a CSS custom property.
                LiveStyle's <code>angle()</code> type generates a CSS <code>@property</code> rule,
                enabling the browser to interpolate angle values smoothly.
              </p>
            </div>
          </div>
        </div>
      </section>

      <%!-- Code Example Section --%>
      <section class={style([:code_section])}>
        <div class={style([:code_inner])}>
          <div class={style([:section_header])}>
            <h2 class={style([:section_title])}>Simple, Declarative API</h2>
            <p class={style([:section_subtitle])}>
              Familiar patterns that feel right at home in Elixir
            </p>
          </div>
          <div class={style([:code_block])}>
            <div class={style([:code_header])}>
              <div class={style([:code_dot, :code_dot_red])}></div>
              <div class={style([:code_dot, :code_dot_yellow])}></div>
              <div class={style([:code_dot, :code_dot_green])}></div>
            </div>
            <pre class={style([:code_pre])}>{code_example()}</pre>
          </div>
        </div>
      </section>

      <%!-- Footer --%>
      <footer class={style([:footer])}>
        <div class={style([:footer_inner])}>
          <p class={style([:footer_text])}>
            Built with
            <a href="https://phoenixframework.org" class={style([:footer_link])}>Phoenix</a>
            and <a href="https://github.com" class={style([:footer_link])}>LiveStyle</a>.
            Inspired by <a href="https://stylexjs.com" class={style([:footer_link])}>StyleX</a>.
          </p>
        </div>
      </footer>
    </div>
    """
  end

  defp theme_classes(dark_mode, base_classes) do
    if dark_mode do
      "#{base_classes} #{Tokens.dark_fill()} #{Tokens.dark_text()} #{Tokens.dark_border()}"
    else
      base_classes
    end
  end
end
