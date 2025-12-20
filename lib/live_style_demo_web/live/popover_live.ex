defmodule LiveStyleDemoWeb.PopoverLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.BaseStyles

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
    padding: css_const({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border_bottom: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle})
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
    padding: css_const({Tokens, :space, :"8"})
  )

  css_class(:section,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    margin_bottom: css_const({Tokens, :space, :"12"})
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

  css_class(:demo_row,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_const({Tokens, :space, :"4"}),
    margin_bottom: css_const({Tokens, :space, :"8"})
  )

  # ============================================================================
  # Demo 1: Basic Popover
  # ============================================================================

  css_class(:popover,
    padding: css_const({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    max_width: "300px",
    # Center the popover
    position: "fixed",
    inset: "0",
    width: "fit-content",
    height: "fit-content",
    margin: "auto",
    # StyleX pattern: pseudo-element as top-level key
    "::backdrop": %{
      background_color: "rgba(0, 0, 0, 0.1)"
    }
  )

  css_class(:popover_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:popover_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  # ============================================================================
  # Demo 2: Manual Popover (no light dismiss)
  # ============================================================================

  css_class(:manual_popover,
    padding: css_const({Tokens, :space, :"6"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    max_width: "350px",
    # Center the popover
    position: "fixed",
    inset: "0",
    width: "fit-content",
    height: "fit-content",
    margin: "auto",
    "::backdrop": %{
      background_color: "rgba(0, 0, 0, 0.3)",
      backdrop_filter: "blur(2px)"
    }
  )

  css_class(:popover_header,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  css_class(:popover_close,
    padding: "4px",
    background: "none",
    border: "none",
    cursor: "pointer",
    border_radius: css_const({Tokens, :radius, :sm}),
    color: %{
      :default => css_var({Tokens, :semantic, :text_muted}),
      ":hover" => css_var({Tokens, :semantic, :text_primary})
    },
    background_color: %{
      :default => "transparent",
      ":hover" => css_var({Tokens, :semantic, :fill_muted})
    }
  )

  css_class(:popover_actions,
    display: "flex",
    gap: css_const({Tokens, :space, :"2"}),
    margin_top: css_const({Tokens, :space, :"4"})
  )

  # ============================================================================
  # Demo 3: Menu Popover
  # ============================================================================

  # Button that triggers the menu - defines an anchor
  css_class(:menu_trigger,
    anchor_name: "--menu-anchor"
  )

  css_class(:menu_popover,
    padding: css_const({Tokens, :space, :"2"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    min_width: "180px",
    # Anchor position below the trigger button
    position: "fixed",
    position_anchor: "--menu-anchor",
    inset: "unset",
    top: "anchor(bottom)",
    left: "anchor(left)",
    margin_top: css_const({Tokens, :space, :"1"})
  )

  css_class(:menu_item,
    display: "flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"2"}),
    padding: "8px 12px",
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_primary}),
    cursor: "pointer",
    transition: "background-color 0.15s ease",
    background_color: %{
      :default => "transparent",
      ":hover" => css_var({Tokens, :semantic, :fill_muted})
    }
  )

  css_class(:menu_divider,
    height: "1px",
    background_color: css_var({Tokens, :semantic, :border_subtle}),
    margin: "4px 0"
  )

  css_class(:menu_item_danger,
    color: css_var({Tokens, :colors, :red_600}),
    background_color: %{
      :default => "transparent",
      ":hover" => css_var({Tokens, :colors, :red_50})
    }
  )

  # ============================================================================
  # Demo 4: Toast Notifications
  # ============================================================================

  css_class(:toast_container,
    position: "fixed",
    bottom: css_const({Tokens, :space, :"4"}),
    right: css_const({Tokens, :space, :"4"}),
    z_index: "1000"
  )

  css_class(:toast,
    align_items: "center",
    gap: css_const({Tokens, :space, :"3"}),
    padding: css_const({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :colors, :gray_900}),
    color: css_var({Tokens, :colors, :white}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    min_width: "280px",
    # Position at bottom right using position-area
    position: "fixed",
    inset: "unset",
    position_area: "bottom right",
    margin: css_const({Tokens, :space, :"4"}),
    # Use display: flex only when popover is open (via :popover-open pseudo-class)
    display: %{
      ":popover-open" => "flex"
    }
  )

  css_class(:toast_success,
    background_color: css_var({Tokens, :colors, :green_600})
  )

  css_class(:toast_icon,
    width: "20px",
    height: "20px",
    flex_shrink: "0"
  )

  css_class(:toast_message,
    flex: "1",
    font_size: css_const({Tokens, :font_size, :sm})
  )

  css_class(:toast_close,
    padding: "4px",
    background: "none",
    border: "none",
    cursor: "pointer",
    color: "inherit",
    opacity: %{
      :default => "0.7",
      ":hover" => "1"
    }
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Popover API")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class={css_class([:page])}>
      <header class={css_class([:header])}>
        <div class={css_class([:header_inner])}>
          <.link navigate="/" class={css_class([:back_link])}>
            ← Back to Home
          </.link>
          <h1 class={css_class([:page_title])}>Popover API</h1>
          <div></div>
        </div>
      </header>

      <main class={css_class([:main])}>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Basic Popover (Auto)</h2>
          <p class={css_class([:section_description])}>
            Click the button to open a popover. Click outside or press Escape to close.
            Uses <code class={css_class([:code_inline])}>popover="auto"</code>
            for light dismiss behavior.
          </p>

          <div class={css_class([:demo_row])}>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
              popovertarget="basic-popover"
            >
              Open Popover
            </button>

            <div id="basic-popover" popover="auto" class={css_class([:popover])}>
              <h3 class={css_class([:popover_title])}>Hello!</h3>
              <p class={css_class([:popover_text])}>
                This is a native HTML popover. It automatically positions itself and handles
                keyboard navigation. Click outside to dismiss.
              </p>
            </div>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Manual Popover</h2>
          <p class={css_class([:section_description])}>
            This popover uses <code class={css_class([:code_inline])}>popover="manual"</code>
            and requires
            explicit closing. Great for confirmation dialogs.
          </p>

          <div class={css_class([:demo_row])}>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
              popovertarget="manual-popover"
            >
              Confirm Action
            </button>

            <div id="manual-popover" popover="manual" class={css_class([:manual_popover])}>
              <div class={css_class([:popover_header])}>
                <h3 class={css_class([:popover_title])}>Confirm Delete</h3>
                <button
                  class={css_class([:popover_close])}
                  popovertarget="manual-popover"
                  popovertargetaction="hide"
                >
                  <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M6 18L18 6M6 6l12 12"
                    />
                  </svg>
                </button>
              </div>
              <p class={css_class([:popover_text])}>
                Are you sure you want to delete this item? This action cannot be undone.
              </p>
              <div class={css_class([:popover_actions])}>
                <button
                  class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
                  popovertarget="manual-popover"
                  popovertargetaction="hide"
                >
                  Cancel
                </button>
                <button
                  class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
                  popovertarget="manual-popover"
                  popovertargetaction="hide"
                  style="background-color: #dc2626;"
                >
                  Delete
                </button>
              </div>
            </div>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Menu Popover</h2>
          <p class={css_class([:section_description])}>
            Dropdown menus are a perfect use case for popovers. They get proper focus management
            and dismiss behavior for free.
          </p>

          <div class={css_class([:demo_row])}>
            <button
              class={
                css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}, :menu_trigger])
              }
              popovertarget="menu-popover"
            >
              Options ▾
            </button>

            <div id="menu-popover" popover="auto" class={css_class([:menu_popover])}>
              <div
                class={css_class([:menu_item])}
                popovertarget="menu-popover"
                popovertargetaction="hide"
              >
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                  />
                </svg>
                Edit
              </div>
              <div
                class={css_class([:menu_item])}
                popovertarget="menu-popover"
                popovertargetaction="hide"
              >
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"
                  />
                </svg>
                Duplicate
              </div>
              <div
                class={css_class([:menu_item])}
                popovertarget="menu-popover"
                popovertargetaction="hide"
              >
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"
                  />
                </svg>
                Archive
              </div>
              <div class={css_class([:menu_divider])}></div>
              <div
                class={css_class([:menu_item, :menu_item_danger])}
                popovertarget="menu-popover"
                popovertargetaction="hide"
              >
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                  />
                </svg>
                Delete
              </div>
            </div>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Toast Notification</h2>
          <p class={css_class([:section_description])}>
            Popovers can be positioned anywhere and styled as notifications.
            They appear in the top layer, above all other content.
          </p>

          <div class={css_class([:demo_row])}>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
              popovertarget="toast-success"
            >
              Show Success Toast
            </button>
          </div>

          <div id="toast-success" popover="auto" class={css_class([:toast, :toast_success])}>
            <svg
              class={css_class([:toast_icon])}
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M5 13l4 4L19 7"
              />
            </svg>
            <span class={css_class([:toast_message])}>Changes saved successfully!</span>
            <button
              class={css_class([:toast_close])}
              popovertarget="toast-success"
              popovertargetaction="hide"
            >
              <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </section>
      </main>
    </div>
    """
  end
end
