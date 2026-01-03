defmodule LiveStyleDemoWeb.ShellComponents do
  @moduledoc """
  Shared application shell (topbar + layout helpers).

  Keeps all demo pages visually consistent while still letting each LiveView
  focus on the actual CSS feature being showcased.
  """

  use Phoenix.Component
  use LiveStyle

  require Phoenix.LiveView.ColocatedHook

  use Phoenix.VerifiedRoutes,
    endpoint: LiveStyleDemoWeb.Endpoint,
    router: LiveStyleDemoWeb.Router,
    statics: LiveStyleDemoWeb.static_paths()

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  import LiveStyleDemoWeb.UIComponents

  # =============================================================================
  # Shell layout styles
  # =============================================================================

  class(:shell,
    position: "relative",
    isolation: "isolate",
    min_height: "100vh",
    background_color: var({Semantic, :fill_surface}),
    color: var({Semantic, :text_primary}),
    font_family: var({Semantic, :font_body}),
    transition: "background-color 200ms ease, color 200ms ease",
    scrollbar_gutter: "stable both-edges"
  )

  class(:topbar,
    position: "sticky",
    top: "0",
    z_index: const({Tokens, :z_sticky}),
    isolation: "isolate",
    background_color: "transparent",
    "::before": [
      content: "''",
      position: "absolute",
      inset: "0",
      z_index: "-1",
      pointer_events: "none",
      background_color: var({Semantic, :fill_glass}),
      backdrop_filter: "blur(14px) saturate(1.2)",
      border_bottom_width: "1px",
      border_bottom_style: "solid",
      border_bottom_color: var({Semantic, :border_glass})
    ]
  )

  class(:menu_backdrop,
    position: "fixed",
    inset: "0",
    background_color: var({Semantic, :overlay_backdrop}),
    backdrop_filter: "blur(2px)",
    # Keep the backdrop below the sticky topbar so the header stays crisp/clickable.
    z_index: const({Tokens, :z_dropdown})
  )

  class(:topbar_inner,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: [
      default: var({Space, :"4"}),
      "@media (max-width: 420px)": var({Space, :"2"})
    ],
    padding_block: [
      default: var({Space, :"4"}),
      "@media (max-width: 420px)": var({Space, :"3"})
    ],
    padding_inline: [
      default: "clamp(1rem, 4vw, 2rem)",
      "@media (max-width: 420px)": "1rem"
    ],
    max_width: "90rem",
    margin_inline: "auto"
  )

  class(:brand,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"3"}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    color: var({Semantic, :text_primary}),
    text_decoration: "none",
    min_width: "0"
  )

  class(:brand_mark,
    width: [default: "2.25rem", "@media (max-width: 420px)": "2rem"],
    height: [default: "2.25rem", "@media (max-width: 420px)": "2rem"],
    border_radius: const({Tokens, :radius_xl}),
    background_color: var({Semantic, :fill_primary}),
    box_shadow: "none"
  )

  class(:brand_text,
    display: ["@media (max-width: 420px)": "none"],
    font_size: const({Tokens, :font_size_lg}),
    line_height: const({Tokens, :leading_tight}),
    white_space: "nowrap"
  )

  class(:nav,
    display: "flex",
    align_items: "center",
    gap: [
      default: var({Space, :"3"}),
      "@media (max-width: 420px)": var({Space, :"2"})
    ],
    flex_shrink: "0"
  )

  # Desktop nav row (kept hidden on phones/landscape)
  class(:nav_links,
    display: [
      default: "none",
      "@media (min-width: 1024px)": "flex"
    ],
    align_items: "center",
    gap: var({Space, :"2"})
  )

  class(:nav_link,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    border_radius: const({Tokens, :radius_full}),
    font_size: const({Tokens, :font_size_sm}),
    font_weight: const({Tokens, :font_weight_medium}),
    color: var({Semantic, :text_secondary}),
    border: "1px solid transparent",
    transition: "background-color 160ms ease, border-color 160ms ease, color 160ms ease",
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{var({Semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"],
    background_color: [
      default: "transparent",
      ":hover": var({Semantic, :fill_glass})
    ],
    border_color: [
      default: "transparent",
      ":hover": var({Semantic, :border_glass})
    ]
  )

  class(:nav_link_active,
    background_color: var({Semantic, :fill_glass}),
    border_color: var({Semantic, :border_glass}),
    color: var({Semantic, :text_primary})
  )

  class(:style_toggle,
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    width: "2.5rem",
    height: "2.5rem",
    border_radius: const({Tokens, :radius_full}),
    background_color: var({Semantic, :fill_glass}),
    border: "1px solid #{var({Semantic, :border_glass})}",
    box_shadow: "0 14px 40px -36px #{var({Semantic, :shadow_color})}",
    color: var({Semantic, :text_primary}),
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{var({Semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  class(:style_menu,
    position: "relative",
    display: "inline-flex"
  )

  class(:style_panel,
    position: "absolute",
    top: "calc(100% + #{var({Space, :"3"})})",
    right: "0",
    width: "min(18rem, 80vw)",
    padding: var({Space, :"4"}),
    border_radius: const({Tokens, :radius_xl}),
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.2)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    box_shadow:
      "0 30px 80px -68px #{var({Semantic, :shadow_color_strong})}, 0 20px 60px -52px #{var({Semantic, :shadow_color})}",
    display: "grid",
    gap: var({Space, :"2"})
  )

  class(:style_btn,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: var({Space, :"2"}),
    width: "100%",
    padding_block: var({Space, :"2.5"}),
    padding_inline: var({Space, :"3"}),
    border_radius: const({Tokens, :radius_lg}),
    border: "1px solid #{var({Semantic, :border_glass})}",
    background_color: var({Semantic, :fill_glass}),
    color: var({Semantic, :text_primary}),
    font_weight: const({Tokens, :font_weight_medium}),
    cursor: "pointer",
    text_align: "left",
    transition: "transform 160ms ease",
    transform: [default: "translateY(0)", ":active": "translateY(1px)"]
  )

  class(:style_btn_active,
    background_color: var({Semantic, :fill_primary}),
    border_color: "transparent",
    color: var({Semantic, :text_on_primary})
  )

  class(:menu,
    position: "relative",
    display: [
      default: "inline-flex",
      "@media (min-width: 1024px)": "none"
    ]
  )

  class(:menu_summary,
    list_style: "none",
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    width: "2.5rem",
    height: "2.5rem",
    border_radius: const({Tokens, :radius_full}),
    background_color: var({Semantic, :fill_glass}),
    border: "1px solid #{var({Semantic, :border_glass})}",
    color: var({Semantic, :text_primary}),
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{var({Semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"],
    "::marker": [content: "''"],
    "::-webkit-details-marker": [display: "none"]
  )

  class(:menu_panel,
    # Mobile menu sheet
    position: "fixed",
    z_index: const({Tokens, :z_modal}),
    left: "max(1rem, env(safe-area-inset-left))",
    right: "max(1rem, env(safe-area-inset-right))",
    top: "calc(4.25rem + env(safe-area-inset-top))",
    max_height: "calc(100vh - 5.25rem - env(safe-area-inset-top) - env(safe-area-inset-bottom))",
    overflow_y: "auto",
    overscroll_behavior: "contain",
    padding: var({Space, :"4"}),
    border_radius: const({Tokens, :radius_xl}),
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.2)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    box_shadow:
      "0 30px 80px -68px #{var({Semantic, :shadow_color_strong})}, 0 20px 60px -52px #{var({Semantic, :shadow_color})}",
    display: "grid",
    gap: var({Space, :"2"})
  )

  class(:menu_divider,
    height: "1px",
    width: "100%",
    background_color: var({Semantic, :border_glass}),
    margin_block: var({Space, :"2"})
  )

  class(:main,
    padding_block: "clamp(1.25rem, 3vw, 2rem)",
    padding_inline: "clamp(1rem, 4vw, 2rem)",
    max_width: "90rem",
    margin_inline: "auto"
  )

  class(:page_header,
    display: "grid",
    gap: var({Space, :"2"}),
    margin_bottom: var({Space, :"8"})
  )

  class(:page_title,
    font_size: "clamp(1.5rem, 1.2rem + 1.5vw, 2.25rem)",
    font_family: var({Semantic, :font_heading}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.03em",
    line_height: const({Tokens, :leading_tight})
  )

  class(:page_subtitle,
    max_width: "70ch",
    color: var({Semantic, :text_secondary}),
    font_size: const({Tokens, :font_size_lg}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:footer,
    margin_top: "clamp(3rem, 5vw, 5rem)",
    padding_block: var({Space, :"10"}),
    padding_inline: "clamp(1rem, 4vw, 2rem)",
    max_width: "90rem",
    margin_inline: "auto",
    border_top: "1px solid #{var({Semantic, :border_glass})}",
    color: var({Semantic, :text_muted})
  )

  class(:footer_inner,
    display: "flex",
    flex_wrap: "wrap",
    align_items: "center",
    justify_content: "space-between",
    gap: var({Space, :"4"})
  )

  class(:footer_link,
    color: var({Semantic, :text_link}),
    text_decoration: [default: "none", ":hover": "underline"]
  )

  class(:kbd,
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_xs}),
    padding_block: var({Space, :"0.5"}),
    padding_inline: var({Space, :"1.5"}),
    border_radius: const({Tokens, :radius_md}),
    background_color: var({Semantic, :fill_glass}),
    border: "1px solid #{var({Semantic, :border_glass})}"
  )

  class(:pagination,
    display: "grid",
    grid_template_columns: "repeat(auto-fit, minmax(200px, 1fr))",
    gap: var({Space, :"4"}),
    margin_top: var({Space, :"16"}),
    padding_top: var({Space, :"8"}),
    border_top: "1px solid #{var({Semantic, :border_glass})}"
  )

  class(:pagination_link,
    display: "flex",
    flex_direction: "column",
    gap: var({Space, :"1"}),
    padding: var({Space, :"4"}),
    border_radius: const({Tokens, :radius_lg}),
    border: "1px solid #{var({Semantic, :border_subtle})}",
    text_decoration: "none",
    color: var({Semantic, :text_primary}),
    transition: "all 0.2s ease",
    background_color: [
      default: "transparent",
      ":hover": var({Semantic, :fill_surface})
    ],
    border_color: [
      default: var({Semantic, :border_subtle}),
      ":hover": var({Semantic, :border_focus})
    ]
  )

  class(:pagination_link_next,
    text_align: "right",
    align_items: "flex-end"
  )

  class(:pagination_label,
    font_size: const({Tokens, :font_size_xs}),
    color: var({Semantic, :text_secondary}),
    text_transform: "uppercase",
    letter_spacing: "0.05em",
    font_weight: const({Tokens, :font_weight_bold})
  )

  class(:pagination_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_semibold})
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
    <div {css(:shell)} data-app-shell>
      <.mobile_menu_hook_definition />
      <.appearance_hook_definition />
      <.spacing_hook_definition />
      <.skip_link target="#main">Skip to content</.skip_link>

      <header {css(:topbar)}>
        <div {css(:topbar_inner)}>
          <.link navigate={~p"/"} {css(:brand)}>
            <span {css(:brand_mark)} aria-hidden="true" />
            <span {css(:brand_text)}>LiveStyle</span>
          </.link>

          <nav {css(:nav)} aria-label="Primary">
            <div {css(:nav_links)}>
              <.nav_link to={~p"/theming"} active={@active == "theming"}>
                Theming
              </.nav_link>
              <.nav_link to={~p"/transitions"} active={@active == "transitions"}>
                Transitions
              </.nav_link>
              <.nav_link to={~p"/components"} active={@active == "components"}>
                Components
              </.nav_link>
              <.nav_link to={~p"/style-guide"} active={@active == "style-guide"}>
                Style Guide
              </.nav_link>
              <.nav_link to={~p"/demos"} active={@active == "demos"}>Demos</.nav_link>
              <a {css(:nav_link)} href="https://github.com/lifeiscontent/live_style">
                GitHub
              </a>
            </div>

            <details id="spacing" {css(:style_menu)} phx-hook=".Spacing">
              <summary {css(:style_toggle)} aria-label="Spacing">
                <span aria-hidden="true">↕</span>
              </summary>

              <div {css(:style_panel)} data-spacing-panel>
                <button type="button" {css(:style_btn)} data-space="default">
                  Default
                </button>
                <button type="button" {css(:style_btn)} data-space="compact">
                  Compact
                </button>
                <button type="button" {css(:style_btn)} data-space="cozy">
                  Cozy
                </button>
              </div>
            </details>

            <details id="appearance" {css(:style_menu)} phx-hook=".Appearance">
              <summary
                {css(:style_toggle)}
                aria-label="Theme"
                data-appearance-toggle
              >
                <span aria-hidden="true" data-appearance-icon>🇨🇭</span>
              </summary>

              <div {css(:style_panel)} data-appearance-panel>
                <button type="button" {css(:style_btn)} data-appearance="default">
                  Swiss
                </button>
                <button type="button" {css(:style_btn)} data-appearance="terminal">
                  Terminal
                </button>
                <button type="button" {css(:style_btn)} data-appearance="blueprint">
                  Blueprint
                </button>
                <button type="button" {css(:style_btn)} data-appearance="solar">
                  Solar
                </button>
                <button type="button" {css(:style_btn)} data-appearance="navy">
                  Navy
                </button>
                <button type="button" {css(:style_btn)} data-appearance="forest">
                  Forest
                </button>
                <button type="button" {css(:style_btn)} data-appearance="lavender">
                  Lavender
                </button>
                <button type="button" {css(:style_btn)} data-appearance="brutal">
                  Brutal
                </button>
              </div>
            </details>

            <details id="mobile-menu" {css(:menu)} phx-hook=".MobileMenu">
              <summary {css(:menu_summary)} aria-label="Open menu">
                <span aria-hidden="true">☰</span>
              </summary>

              <div {css(:menu_backdrop)} data-mobile-menu-backdrop aria-hidden="true" />
              <div {css(:menu_panel)} data-mobile-menu-panel role="menu">
                <.nav_link to={~p"/theming"} active={@active == "theming"}>
                  Theming
                </.nav_link>
                <.nav_link to={~p"/transitions"} active={@active == "transitions"}>
                  Transitions
                </.nav_link>
                <.nav_link to={~p"/components"} active={@active == "components"}>
                  Components
                </.nav_link>
                <.nav_link to={~p"/style-guide"} active={@active == "style-guide"}>
                  Style Guide
                </.nav_link>
                <.nav_link to={~p"/demos"} active={@active == "demos"}>Demos</.nav_link>

                <div {css(:menu_divider)} />

                <.button variant={:secondary} href="https://github.com/lifeiscontent/live_style">
                  GitHub
                </.button>

                <.button variant={:primary} navigate={~p"/"}>
                  Home
                </.button>
              </div>
            </details>
          </nav>
        </div>
      </header>

      <main id="main" {css(:main)}>
        <header :if={@page_title || @page_subtitle} {css(:page_header)}>
          <h1 :if={@page_title} {css(:page_title)}>{@page_title}</h1>
          <p :if={@page_subtitle} {css(:page_subtitle)}>{@page_subtitle}</p>
        </header>

        {render_slot(@inner_block)}

        <.pagination active={@active} />
      </main>

      <footer :if={@show_footer} {css(:footer)}>
        <div {css(:footer_inner)}>
          <p>
            Built with <a {css(:footer_link)} href="https://phoenixframework.org">Phoenix</a>
            and <a
              {css(:footer_link)}
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

  defp pages do
    [
      {"home", "Home", "/"},
      {"theming", "Theming", "/theming"},
      {"components", "Components", "/components"},
      {"style-guide", "Style Guide", "/style-guide"},
      {"transitions", "Transitions", "/transitions"},
      {"anchor", "Anchor Positioning", "/anchor"},
      {"color", "Color & OKLCH", "/color"},
      {"parent-selector", "Parent Selector (:has)", "/parent-selector"},
      {"popover", "Popover API", "/popover"},
      {"container", "Container Queries", "/container"},
      {"scroll", "Scroll Animations", "/scroll"},
      {"starting-style", "@starting-style", "/starting-style"},
      {"focus-card", "Focus Card", "/focus-card"},
      {"todo", "Todo App", "/todo"},
      {"table", "Price Table", "/table"}
    ]
  end

  attr(:active, :string, default: nil)

  def pagination(assigns) do
    all = pages()
    idx = Enum.find_index(all, fn {id, _, _} -> id == assigns.active end)

    assigns =
      assign(assigns,
        prev: if(idx && idx > 0, do: Enum.at(all, idx - 1)),
        next: if(idx && idx < length(all) - 1, do: Enum.at(all, idx + 1))
      )

    ~H"""
    <nav :if={@prev || @next} {css(:pagination)} aria-label="Pagination">
      <.link :if={@prev} navigate={elem(@prev, 2)} {css(:pagination_link)}>
        <span {css(:pagination_label)}>&larr; Previous</span>
        <span {css(:pagination_title)}>{elem(@prev, 1)}</span>
      </.link>
      <div :if={!@prev}></div>

      <.link
        :if={@next}
        navigate={elem(@next, 2)}
        {css([:pagination_link, :pagination_link_next])}
      >
        <span {css(:pagination_label)}>Next &rarr;</span>
        <span {css(:pagination_title)}>{elem(@next, 1)}</span>
      </.link>
    </nav>
    """
  end

  def appearance_hook_definition(assigns) do
    assigns =
      assigns
      |> assign(:style_btn_base_class, css(:style_btn).class)
      |> assign(:style_btn_active_class, css([:style_btn, :style_btn_active]).class)

    ~H"""
    <div
      id="appearance-hook-def"
      hidden
      aria-hidden="true"
      data-style-btn-base-class={@style_btn_base_class}
      data-style-btn-active-class={@style_btn_active_class}
    >
      <script :type={Phoenix.LiveView.ColocatedHook} name=".Appearance">
        const APPEARANCE_KEY = "ls-appearance"

        function getStyleClasses() {
          const el = document.getElementById("appearance-hook-def")
          return {
            base: el?.dataset?.styleBtnBaseClass || "",
            active: el?.dataset?.styleBtnActiveClass || ""
          }
        }

        function splitClasses(classString) {
          return (classString || "").split(/\s+/).filter(Boolean)
        }

        function normalizeAppearance() {
          const stored = window.localStorage?.getItem(APPEARANCE_KEY)
          if (stored) return stored
          return "default"
        }

        function appearanceInfo(value) {
          switch (value) {
            case "terminal":
              return {label: "Terminal", icon: "🟩"}
            case "blueprint":
              return {label: "Blueprint", icon: "🟦"}
            case "solar":
              return {label: "Solar", icon: "☀️"}
            case "navy":
              return {label: "Navy", icon: "🌊"}
            case "forest":
              return {label: "Forest", icon: "🌲"}
            case "lavender":
              return {label: "Lavender", icon: "💜"}
            case "brutal":
              return {label: "Brutal", icon: "🔨"}
            default:
              return {label: "Swiss", icon: "🇨🇭"}
          }
        }

        function syncToggle(value, root) {
          const {label, icon} = appearanceInfo(value)
          const toggle = root.querySelector("[data-appearance-toggle]")
          if (!toggle) return

          const iconEl = toggle.querySelector("[data-appearance-icon]")
          if (iconEl) iconEl.textContent = icon

          toggle.title = `Theme: ${label}`
        }

        function applyAppearance(value) {
          const root = document.documentElement

          const themeClasses = {
            "terminal": root.dataset.styleTerminalClass,
            "blueprint": root.dataset.styleBlueprintClass,
            "solar": root.dataset.styleSolarClass,
            "navy": root.dataset.styleNavyClass,
            "forest": root.dataset.styleForestClass,
            "lavender": root.dataset.styleLavenderClass,
            "brutal": root.dataset.styleBrutalClass,
          }

          // Remove all theme classes
          Object.values(themeClasses).forEach((classString) => {
            if (classString) {
              splitClasses(classString).forEach((cls) => root.classList.remove(cls))
            }
          })

          if (value !== "default" && themeClasses[value]) {
             splitClasses(themeClasses[value]).forEach((cls) => root.classList.add(cls))
          }

          root.dataset.theme = value

          syncToggle(value, root)

          try {
            window.localStorage?.setItem(APPEARANCE_KEY, value)
          } catch (_err) {
            // ignore
          }
        }

        function setActive(panel, value) {
          const classes = getStyleClasses()

          panel.querySelectorAll("[data-appearance]").forEach((btn) => {
            const isActive = btn.getAttribute("data-appearance") === value
            btn.className = isActive ? classes.active : classes.base
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
              const next = btn.getAttribute("data-appearance") || "default"
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
    assigns =
      assigns
      |> assign(:style_btn_base_class, css(:style_btn).class)
      |> assign(:style_btn_active_class, css([:style_btn, :style_btn_active]).class)

    ~H"""
    <div
      id="spacing-hook-def"
      hidden
      aria-hidden="true"
      data-style-btn-base-class={@style_btn_base_class}
      data-style-btn-active-class={@style_btn_active_class}
    >
      <script :type={Phoenix.LiveView.ColocatedHook} name=".Spacing">
        const SPACE_KEY = "ls-space"

        function getStyleClasses() {
          const el = document.getElementById("spacing-hook-def")
          return {
            base: el?.dataset?.styleBtnBaseClass || "",
            active: el?.dataset?.styleBtnActiveClass || ""
          }
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

          if (classes[value]) {
            splitClasses(classes[value]).forEach((cls) => root.classList.add(cls))
          }
          root.dataset.spaceScale = value

          try {
            window.localStorage?.setItem(SPACE_KEY, value)
          } catch (_err) {
            // ignore
          }
        }

        function setActive(panel, value) {
          const classes = getStyleClasses()

          panel.querySelectorAll("[data-space]").forEach((btn) => {
            const isActive = btn.getAttribute("data-space") === value
            btn.className = isActive ? classes.active : classes.base
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
      {css([:nav_link, @active && :nav_link_active])}
      aria-current={@active && "page"}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end
end
