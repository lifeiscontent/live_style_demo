defmodule LiveStyleDemoWeb.ShellComponents do
  @moduledoc """
  Shared application shell (topbar + layout helpers).

  Keeps all demo pages visually consistent while still letting each LiveView
  focus on the actual CSS feature being showcased.
  """

  use Phoenix.Component
  use LiveStyle.Sheet

  require Phoenix.LiveView.ColocatedHook

  use Phoenix.VerifiedRoutes,
    endpoint: LiveStyleDemoWeb.Endpoint,
    router: LiveStyleDemoWeb.Router,
    statics: LiveStyleDemoWeb.static_paths()

  # Ensure tokens/styles compile first
  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles

  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  # =============================================================================
  # Shell layout styles
  # =============================================================================

  css_class(:shell,
    position: "relative",
    isolation: "isolate",
    min_height: "100vh",
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    color: css_var({Tokens, :semantic, :text_primary}),
    font_family: css_var({Tokens, :semantic, :font_body}),
    transition: "background-color 200ms ease, color 200ms ease",
    scrollbar_gutter: "stable both-edges",
    "::before": %{
      content: "''",
      position: "fixed",
      inset: "0",
      z_index: "-1",
      pointer_events: "none",
      background_image:
        "radial-gradient(1100px circle at 15% 0%, #{css_var({Tokens, :semantic, :glow_primary})}, transparent 55%), radial-gradient(900px circle at 95% 10%, #{css_var({Tokens, :semantic, :glow_secondary})}, transparent 60%), radial-gradient(1400px circle at 50% 115%, color-mix(in oklab, #{css_var({Tokens, :semantic, :text_accent})} 12%, transparent), transparent 70%)",
      filter: "saturate(1.15)",
      opacity: "0.95",
      transform: "translateZ(0)"
    }
  )

  css_class(:topbar,
    position: "sticky",
    top: "0",
    z_index: css_const({Tokens, :z, :sticky}),
    isolation: "isolate",
    background_color: "transparent",
    "::before": %{
      content: "''",
      position: "absolute",
      inset: "0",
      z_index: "-1",
      pointer_events: "none",
      background_color: css_var({Tokens, :semantic, :fill_glass}),
      backdrop_filter: "blur(14px) saturate(1.2)",
      border_bottom_width: "1px",
      border_bottom_style: "solid",
      border_bottom_color: css_var({Tokens, :semantic, :border_glass})
    }
  )

  css_class(:menu_backdrop,
    position: "fixed",
    inset: "0",
    background_color: css_var({Tokens, :semantic, :overlay_backdrop}),
    backdrop_filter: "blur(2px)",
    # Keep the backdrop below the sticky topbar so the header stays crisp/clickable.
    z_index: css_const({Tokens, :z, :dropdown})
  )

  css_class(:topbar_inner,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: [
      default: css_var({Tokens, :space, :"4"}),
      "@media (max-width: 420px)": css_var({Tokens, :space, :"2"})
    ],
    padding_block: [
      default: css_var({Tokens, :space, :"4"}),
      "@media (max-width: 420px)": css_var({Tokens, :space, :"3"})
    ],
    padding_inline: [
      default: "clamp(1rem, 4vw, 2rem)",
      "@media (max-width: 420px)": "1rem"
    ],
    max_width: "90rem",
    margin_inline: "auto"
  )

  css_class(:brand,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    color: css_var({Tokens, :semantic, :text_primary}),
    text_decoration: "none",
    min_width: "0"
  )

  css_class(:brand_mark,
    width: [default: "2.25rem", "@media (max-width: 420px)": "2rem"],
    height: [default: "2.25rem", "@media (max-width: 420px)": "2rem"],
    border_radius: css_const({Tokens, :radius, :xl}),
    background_image: css_const({Tokens, :gradient, :primary}),
    box_shadow:
      "0 18px 50px -42px #{css_var({Tokens, :semantic, :glow_primary})}, 0 18px 55px -48px #{css_var({Tokens, :semantic, :shadow_color_strong})}"
  )

  css_class(:brand_text,
    display: ["@media (max-width: 420px)": "none"],
    font_size: css_const({Tokens, :font_size, :lg}),
    line_height: css_const({Tokens, :leading, :tight}),
    white_space: "nowrap"
  )

  css_class(:nav,
    display: "flex",
    align_items: "center",
    gap: [
      default: css_var({Tokens, :space, :"3"}),
      "@media (max-width: 420px)": css_var({Tokens, :space, :"2"})
    ],
    flex_shrink: "0"
  )

  # Desktop nav row (kept hidden on phones/landscape)
  css_class(:nav_links,
    display: [
      default: "none",
      "@media (min-width: 1024px)": "flex"
    ],
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"})
  )

  css_class(:nav_link,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border_radius: css_const({Tokens, :radius, :full}),
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    border: "1px solid transparent",
    transition: "background-color 160ms ease, border-color 160ms ease, color 160ms ease",
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"],
    background_color: [
      default: "transparent",
      ":hover": css_var({Tokens, :semantic, :fill_glass})
    ],
    border_color: [
      default: "transparent",
      ":hover": css_var({Tokens, :semantic, :border_glass})
    ]
  )

  css_class(:nav_link_active,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    border_color: css_var({Tokens, :semantic, :border_glass}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:style_toggle,
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    width: "2.5rem",
    height: "2.5rem",
    border_radius: css_const({Tokens, :radius, :full}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    box_shadow: "0 14px 40px -36px #{css_var({Tokens, :semantic, :shadow_color})}",
    color: css_var({Tokens, :semantic, :text_primary}),
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  css_class(:style_menu,
    position: "relative",
    display: "inline-flex"
  )

  css_class(:style_panel,
    position: "absolute",
    top: "calc(100% + #{css_var({Tokens, :space, :"3"})})",
    right: "0",
    width: "min(18rem, 80vw)",
    padding: css_var({Tokens, :space, :"4"}),
    border_radius: css_const({Tokens, :radius, :xl}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.2)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    box_shadow:
      "0 30px 80px -68px #{css_var({Tokens, :semantic, :shadow_color_strong})}, 0 20px 60px -52px #{css_var({Tokens, :semantic, :shadow_color})}",
    display: "grid",
    gap: css_var({Tokens, :space, :"2"})
  )

  css_class(:style_btn,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: css_var({Tokens, :space, :"2"}),
    width: "100%",
    padding_block: css_var({Tokens, :space, :"2.5"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border_radius: css_const({Tokens, :radius, :lg}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    color: css_var({Tokens, :semantic, :text_primary}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    cursor: "pointer",
    text_align: "left",
    transition: "transform 160ms ease",
    transform: [default: "translateY(0)", ":active": "translateY(1px)"]
  )

  css_class(:style_btn_active,
    background_image: css_const({Tokens, :gradient, :accent}),
    border_color: "transparent",
    color: css_var({Tokens, :semantic, :text_inverse})
  )

  css_class(:menu,
    position: "relative",
    display: [
      default: "inline-flex",
      "@media (min-width: 1024px)": "none"
    ]
  )

  css_class(:menu_summary,
    list_style: "none",
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    width: "2.5rem",
    height: "2.5rem",
    border_radius: css_const({Tokens, :radius, :full}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    color: css_var({Tokens, :semantic, :text_primary}),
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"],
    "::marker": %{content: "''"},
    "::-webkit-details-marker": %{display: "none"}
  )

  css_class(:menu_panel,
    # Mobile menu sheet
    position: "fixed",
    z_index: css_const({Tokens, :z, :modal}),
    left: "max(1rem, env(safe-area-inset-left))",
    right: "max(1rem, env(safe-area-inset-right))",
    top: "calc(4.25rem + env(safe-area-inset-top))",
    max_height: "calc(100vh - 5.25rem - env(safe-area-inset-top) - env(safe-area-inset-bottom))",
    overflow_y: "auto",
    overscroll_behavior: "contain",
    padding: css_var({Tokens, :space, :"4"}),
    border_radius: css_const({Tokens, :radius, :xl}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.2)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    box_shadow:
      "0 30px 80px -68px #{css_var({Tokens, :semantic, :shadow_color_strong})}, 0 20px 60px -52px #{css_var({Tokens, :semantic, :shadow_color})}",
    display: "grid",
    gap: css_var({Tokens, :space, :"2"})
  )

  css_class(:menu_divider,
    height: "1px",
    width: "100%",
    background_color: css_var({Tokens, :semantic, :border_glass}),
    margin_block: css_var({Tokens, :space, :"2"})
  )

  css_class(:main,
    padding_block: "clamp(1.25rem, 3vw, 2rem)",
    padding_inline: "clamp(1rem, 4vw, 2rem)",
    max_width: "90rem",
    margin_inline: "auto"
  )

  css_class(:page_header,
    display: "grid",
    gap: css_var({Tokens, :space, :"2"}),
    margin_bottom: css_var({Tokens, :space, :"8"})
  )

  css_class(:page_title,
    font_size: "clamp(1.5rem, 1.2rem + 1.5vw, 2.25rem)",
    font_family: css_var({Tokens, :semantic, :font_heading}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.03em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:page_subtitle,
    max_width: "70ch",
    color: css_var({Tokens, :semantic, :text_secondary}),
    font_size: css_const({Tokens, :font_size, :lg}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:footer,
    margin_top: "clamp(3rem, 5vw, 5rem)",
    padding_block: css_var({Tokens, :space, :"10"}),
    padding_inline: "clamp(1rem, 4vw, 2rem)",
    max_width: "90rem",
    margin_inline: "auto",
    border_top: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:footer_inner,
    display: "flex",
    flex_wrap: "wrap",
    align_items: "center",
    justify_content: "space-between",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:footer_link,
    color: css_var({Tokens, :semantic, :text_link}),
    text_decoration: [default: "none", ":hover": "underline"]
  )

  css_class(:kbd,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :xs}),
    padding_block: css_var({Tokens, :space, :"0.5"}),
    padding_inline: css_var({Tokens, :space, :"1.5"}),
    border_radius: css_const({Tokens, :radius, :md}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}"
  )

  # =============================================================================
  # Components
  # =============================================================================

  attr(:page_title, :string, default: nil)
  attr(:page_subtitle, :string, default: nil)
  attr(:active, :string, default: nil)
  attr(:show_footer, :boolean, default: true)
  slot(:inner_block, required: true)

  def shell(assigns) do
    ~H"""
    <div class={css_class([:shell])} data-app-shell>
      <.mobile_menu_hook_definition />
      <.appearance_hook_definition />
      <.spacing_hook_definition />
      <a href="#main" class={css_class([{BaseStyles, :sr_only}])}>Skip to content</a>

      <header class={css_class([:topbar])}>
        <div class={css_class([:topbar_inner])}>
          <.link navigate={~p"/"} class={css_class([:brand])}>
            <span class={css_class([:brand_mark])} aria-hidden="true" />
            <span class={css_class([:brand_text])}>LiveStyle</span>
          </.link>

          <nav class={css_class([:nav])} aria-label="Primary">
            <div class={css_class([:nav_links])}>
              <.nav_link to={~p"/six-month-test"} active={@active == "six-month-test"}>
                Six-Month Test
              </.nav_link>
              <.nav_link to={~p"/transitions"} active={@active == "transitions"}>
                Transitions
              </.nav_link>
              <.nav_link to={~p"/clean-heex"} active={@active == "clean-heex"}>
                Clean HEEx
              </.nav_link>
              <.nav_link to={~p"/demos"} active={@active == "demos"}>Demos</.nav_link>
              <a class={css_class([:nav_link])} href="https://github.com/lifeiscontent/live_style">
                GitHub
              </a>
            </div>

            <details id="spacing" class={css_class([:style_menu])} phx-hook=".Spacing">
              <summary class={css_class([:style_toggle])} aria-label="Spacing">
                <span aria-hidden="true">↕</span>
              </summary>

              <div class={css_class([:style_panel])} data-spacing-panel>
                <button type="button" class={css_class([:style_btn])} data-space="default">
                  Default spacing
                </button>
                <button type="button" class={css_class([:style_btn])} data-space="compact">
                  Compact
                </button>
                <button type="button" class={css_class([:style_btn])} data-space="cozy">
                  Cozy
                </button>
              </div>
            </details>

            <details id="appearance" class={css_class([:style_menu])} phx-hook=".Appearance">
              <summary class={css_class([:style_toggle])} aria-label="Theme">
                <span aria-hidden="true">◐</span>
              </summary>

              <div class={css_class([:style_panel])} data-appearance-panel>
                <button type="button" class={css_class([:style_btn])} data-appearance="default-light">
                  Default (Light)
                </button>
                <button type="button" class={css_class([:style_btn])} data-appearance="default-dark">
                  Default (Dark)
                </button>

                <div class={css_class([:menu_divider])} />

                <button type="button" class={css_class([:style_btn])} data-appearance="zen-paper">
                  Paper
                </button>
                <button type="button" class={css_class([:style_btn])} data-appearance="zen-neon">
                  Neon Night
                </button>
                <button type="button" class={css_class([:style_btn])} data-appearance="zen-terminal">
                  Terminal
                </button>
                <button type="button" class={css_class([:style_btn])} data-appearance="zen-brutalist">
                  Brutalist
                </button>
              </div>
            </details>

            <details id="mobile-menu" class={css_class([:menu])} phx-hook=".MobileMenu">
              <summary class={css_class([:menu_summary])} aria-label="Open menu">
                <span aria-hidden="true">☰</span>
              </summary>

              <div class={css_class([:menu_backdrop])} data-mobile-menu-backdrop aria-hidden="true" />
              <div class={css_class([:menu_panel])} data-mobile-menu-panel role="menu">
                <.nav_link to={~p"/six-month-test"} active={@active == "six-month-test"}>
                  Six-Month Test
                </.nav_link>
                <.nav_link to={~p"/transitions"} active={@active == "transitions"}>
                  Transitions
                </.nav_link>
                <.nav_link to={~p"/clean-heex"} active={@active == "clean-heex"}>
                  Clean HEEx
                </.nav_link>
                <.nav_link to={~p"/demos"} active={@active == "demos"}>Demos</.nav_link>

                <div class={css_class([:menu_divider])} />

                <a
                  class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
                  href="https://github.com/lifeiscontent/live_style"
                >
                  GitHub
                </a>

                <.link
                  navigate={~p"/"}
                  class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
                >
                  Home
                </.link>
              </div>
            </details>
          </nav>
        </div>
      </header>

      <main id="main" class={css_class([:main])}>
        <header :if={@page_title || @page_subtitle} class={css_class([:page_header])}>
          <h1 :if={@page_title} class={css_class([:page_title])}>{@page_title}</h1>
          <p :if={@page_subtitle} class={css_class([:page_subtitle])}>{@page_subtitle}</p>
        </header>

        {render_slot(@inner_block)}
      </main>

      <footer :if={@show_footer} class={css_class([:footer])}>
        <div class={css_class([:footer_inner])}>
          <p>
            Built with
            <a class={css_class([:footer_link])} href="https://phoenixframework.org">Phoenix</a>
            and <a
              class={css_class([:footer_link])}
              href="https://github.com/lifeiscontent/live_style"
            >LiveStyle</a>.
          </p>
          <p>
            Choose theme + spacing in the header.
          </p>
        </div>
      </footer>
    </div>
    """
  end

  def appearance_hook_definition(assigns) do
    assigns = assign(assigns, :style_btn_active_class, css_class([:style_btn_active]))

    ~H"""
    <div
      id="appearance-hook-def"
      hidden
      aria-hidden="true"
      data-style-btn-active-class={@style_btn_active_class}
    >
      <script :type={Phoenix.LiveView.ColocatedHook} name=".Appearance">
        const APPEARANCE_KEY = "ls-appearance"

        function activeClasses() {
          const el = document.getElementById("appearance-hook-def")
          return (el?.dataset?.styleBtnActiveClass || "").split(/\s+/).filter(Boolean)
        }

        function splitClasses(classString) {
          return (classString || "").split(/\s+/).filter(Boolean)
        }

        function normalizeAppearance() {
          // Migrate from older keys if present.
          const stored = window.localStorage?.getItem(APPEARANCE_KEY)
          if (stored) return stored

          const legacyStyle = window.localStorage?.getItem("ls-style") || "default"
          const legacyTheme = window.localStorage?.getItem("ls-theme") || "light"

          const value =
            legacyStyle !== "default"
              ? legacyStyle
              : legacyTheme === "dark"
                ? "default-dark"
                : "default-light"

          try {
            window.localStorage?.setItem(APPEARANCE_KEY, value)
          } catch (_err) {
            // ignore
          }

          return value
        }

        function applyAppearance(value) {
          const root = document.documentElement
          const darkClass = root.dataset.themeDarkClass

          const themeClasses = {
            "zen-brutalist": root.dataset.styleZenBrutalistClass,
            "zen-paper": root.dataset.styleZenPaperClass,
            "zen-neon": root.dataset.styleZenNeonClass,
            "zen-terminal": root.dataset.styleZenTerminalClass,
          }

          // Remove all zen theme classes.
          Object.values(themeClasses).forEach((classString) => {
            splitClasses(classString).forEach((cls) => root.classList.remove(cls))
          })

          if (darkClass) root.classList.remove(darkClass)

          let colorScheme = "light"

          if (value === "default-dark") {
            if (darkClass) root.classList.add(darkClass)
            colorScheme = "dark"
          } else if (value === "default-light") {
            colorScheme = "light"
          } else {
            splitClasses(themeClasses[value]).forEach((cls) => root.classList.add(cls))
            colorScheme = value === "zen-neon" || value === "zen-terminal" ? "dark" : "light"
          }

          root.dataset.theme = colorScheme
          root.style.colorScheme = colorScheme

          try {
            window.localStorage?.setItem(APPEARANCE_KEY, value)
          } catch (_err) {
            // ignore
          }
        }

        function setActive(panel, value) {
          const classes = activeClasses()

          panel.querySelectorAll("[data-appearance]").forEach((btn) => {
            const isActive = btn.getAttribute("data-appearance") === value
            classes.forEach((cls) => btn.classList.toggle(cls, isActive))
          })
        }

        export default {
          mounted() {
            this.panel = this.el.querySelector("[data-appearance-panel]")
            if (!this.panel) return

            const value = normalizeAppearance()
            applyAppearance(value)
            setActive(this.panel, value)

            this.onPanelClick = (event) => {
              const target = event.target
              if (!(target instanceof Element)) return

              const btn = target.closest("[data-appearance]")
              if (!btn) return

              event.preventDefault()
              const next = btn.getAttribute("data-appearance") || "default-light"
              applyAppearance(next)
              setActive(this.panel, next)
              this.el.open = false
            }

            this.onDocClick = (event) => {
              if (!this.el.open) return
              const target = event.target
              if (!(target instanceof Element)) return
              if (target.closest("#appearance")) return
              this.el.open = false
            }

            this.onKeyDown = (event) => {
              if (event.key === "Escape" && this.el.open) {
                this.el.open = false
              }
            }

            this.panel.addEventListener("click", this.onPanelClick)
            document.addEventListener("click", this.onDocClick, true)
            window.addEventListener("keydown", this.onKeyDown)
          },

          destroyed() {
            if (this.panel) this.panel.removeEventListener("click", this.onPanelClick)
            document.removeEventListener("click", this.onDocClick, true)
            window.removeEventListener("keydown", this.onKeyDown)
          },
        }
      </script>
    </div>
    """
  end

  def spacing_hook_definition(assigns) do
    assigns = assign(assigns, :style_btn_active_class, css_class([:style_btn_active]))

    ~H"""
    <div
      id="spacing-hook-def"
      hidden
      aria-hidden="true"
      data-style-btn-active-class={@style_btn_active_class}
    >
      <script :type={Phoenix.LiveView.ColocatedHook} name=".Spacing">
        const SPACE_KEY = "ls-space"

        function activeClasses() {
          const el = document.getElementById("spacing-hook-def")
          return (el?.dataset?.styleBtnActiveClass || "").split(/\s+/).filter(Boolean)
        }

        function splitClasses(classString) {
          return (classString || "").split(/\s+/).filter(Boolean)
        }

        function applySpacing(value) {
          const root = document.documentElement
          const classes = {
            compact: root.dataset.spaceCompactClass,
            cozy: root.dataset.spaceCozyClass,
          }

          Object.values(classes).forEach((classString) => {
            splitClasses(classString).forEach((cls) => root.classList.remove(cls))
          })

          splitClasses(classes[value]).forEach((cls) => root.classList.add(cls))
          root.dataset.spaceScale = value

          try {
            window.localStorage?.setItem(SPACE_KEY, value)
          } catch (_err) {
            // ignore
          }
        }

        function setActive(panel, value) {
          const classes = activeClasses()

          panel.querySelectorAll("[data-space]").forEach((btn) => {
            const isActive = btn.getAttribute("data-space") === value
            classes.forEach((cls) => btn.classList.toggle(cls, isActive))
          })
        }

        export default {
          mounted() {
            this.panel = this.el.querySelector("[data-spacing-panel]")
            if (!this.panel) return

            const stored = window.localStorage?.getItem(SPACE_KEY) || "default"
            applySpacing(stored)
            setActive(this.panel, stored)

            this.onPanelClick = (event) => {
              const target = event.target
              if (!(target instanceof Element)) return

              const btn = target.closest("[data-space]")
              if (!btn) return

              event.preventDefault()
              const next = btn.getAttribute("data-space") || "default"
              applySpacing(next)
              setActive(this.panel, next)
              this.el.open = false
            }

            this.onDocClick = (event) => {
              if (!this.el.open) return
              const target = event.target
              if (!(target instanceof Element)) return
              if (target.closest("#spacing")) return
              this.el.open = false
            }

            this.onKeyDown = (event) => {
              if (event.key === "Escape" && this.el.open) {
                this.el.open = false
              }
            }

            this.panel.addEventListener("click", this.onPanelClick)
            document.addEventListener("click", this.onDocClick, true)
            window.addEventListener("keydown", this.onKeyDown)
          },

          destroyed() {
            if (this.panel) this.panel.removeEventListener("click", this.onPanelClick)
            document.removeEventListener("click", this.onDocClick, true)
            window.removeEventListener("keydown", this.onKeyDown)
          },
        }
      </script>
    </div>
    """
  end

  def mobile_menu_hook_definition(assigns) do
    ~H"""
    <div id="mobile-menu-hook-def" hidden aria-hidden="true">
      <script :type={Phoenix.LiveView.ColocatedHook} name=".MobileMenu">
        export default {
          mounted() {
            this.onDocumentClick = (event) => {
              if (!this.el.open) return
              const target = event.target
              if (!(target instanceof Element)) return

              // Keep menu open for clicks inside the panel.
              if (target.closest("[data-mobile-menu-panel]")) {
                // Selecting a link inside the panel closes the menu.
                if (target.closest("a")) this.el.open = false
                return
              }

              // Clicking the summary toggles the <details> normally.
              if (target.closest("summary")) return

              // Any other click (including the topbar) dismisses.
              this.el.open = false
            }

            this.onKeyDown = (event) => {
              if (event.key === "Escape" && this.el.open) {
                this.el.open = false
              }
            }

            document.addEventListener("click", this.onDocumentClick, true)
            window.addEventListener("keydown", this.onKeyDown)
          },

          destroyed() {
            document.removeEventListener("click", this.onDocumentClick, true)
            window.removeEventListener("keydown", this.onKeyDown)
          },
        }
      </script>
    </div>
    """
  end

  attr(:to, :string, required: true)
  attr(:active, :boolean, default: false)
  slot(:inner_block, required: true)

  def nav_link(assigns) do
    ~H"""
    <.link
      navigate={@to}
      class={css_class([:nav_link, @active && :nav_link_active])}
      aria-current={@active && "page"}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end
end
