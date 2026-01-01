defmodule LiveStyleDemoWeb.PopoverLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:demo_row,
    display: "flex",
    flex_wrap: "wrap",
    gap: var({Space, :"4"}),
    margin_bottom: var({Space, :"8"})
  )

  # ============================================================================
  # Demo 1: Basic Popover
  # ============================================================================

  class(:popover,
    padding: var({Space, :"6"}),
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid",
    border_color: var({Semantic, :border_glass}),
    border_radius: const({Tokens, :radius_lg}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    max_width: "min(300px, calc(100vw - #{var({Space, :"8"})}))",
    # Center the popover
    position: "fixed",
    inset: "0",
    width: "fit-content",
    height: "fit-content",
    margin: "auto",
    # StyleX pattern: pseudo-element as top-level key
    "::backdrop": [
      background_color: var({Semantic, :overlay_backdrop})
    ]
  )

  class(:popover_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_semibold}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"2"})
  )

  class(:popover_text,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  # ============================================================================
  # Demo 2: Manual Popover (no light dismiss)
  # ============================================================================

  class(:manual_popover,
    padding: var({Space, :"6"}),
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid",
    border_color: var({Semantic, :border_glass}),
    border_radius: const({Tokens, :radius_lg}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    max_width: "min(350px, calc(100vw - #{var({Space, :"8"})}))",
    # Center the popover
    position: "fixed",
    inset: "0",
    width: "fit-content",
    height: "fit-content",
    margin: "auto",
    "::backdrop": [
      background_color: var({Semantic, :overlay_backdrop}),
      backdrop_filter: "blur(2px)"
    ]
  )

  class(:popover_header,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    margin_bottom: var({Space, :"4"})
  )

  class(:popover_close,
    padding: var({Space, :"1"}),
    background: "none",
    border: "none",
    cursor: "pointer",
    border_radius: const({Tokens, :radius_sm}),
    color: [
      default: var({Semantic, :text_muted}),
      ":hover": var({Semantic, :text_primary})
    ],
    background_color: [
      default: "transparent",
      ":hover": var({Semantic, :fill_muted})
    ]
  )

  class(:popover_actions,
    display: "flex",
    flex_wrap: "wrap",
    gap: var({Space, :"2"}),
    margin_top: var({Space, :"4"})
  )

  # ============================================================================
  # Demo 3: Menu Popover
  # ============================================================================

  # Button that triggers the menu - defines an anchor
  class(:menu_trigger,
    anchor_name: "--menu-anchor"
  )

  class(:menu_position,
    # Anchor position below the trigger button
    position: "fixed",
    position_anchor: "--menu-anchor",
    inset: "unset",
    top: "anchor(bottom)",
    left: "anchor(left)",
    margin_top: var({Space, :"1"}),
    # Reset browser default popover styles on the wrapper
    border: "none",
    padding: "0",
    background: "transparent",
    box_shadow: "none",
    color: "inherit"
  )

  # ============================================================================
  # Demo 4: Toast Notifications
  # ============================================================================

  # Layout concern: where the toast appears.
  class(:toast_position,
    position: "fixed",
    top: "auto",
    left: "auto",
    bottom: "max(#{var({Space, :"4"})}, env(safe-area-inset-bottom))",
    right: "max(#{var({Space, :"4"})}, env(safe-area-inset-right))",
    # Reset browser default popover styles on the wrapper
    border: "none",
    padding: "0",
    background: "transparent",
    box_shadow: "none",
    color: "inherit"
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
    <.shell
      active="popover"
      page_title="Popover API"
      page_subtitle="Native popovers: modals, menus, toasts."
    >
      <.demo_section>
        <.demo_section_title>Basic Popover (Auto)</.demo_section_title>
        <.demo_section_description>
          Click the button to open a popover. Click outside or press Escape to close.
          Uses
          <.code_inline>popover="auto"</.code_inline>
          for light dismiss behavior.
        </.demo_section_description>

        <div {css(:demo_row)}>
          <.button variant={:primary} popovertarget="basic-popover">
            Open Popover
          </.button>

          <div id="basic-popover" popover="auto" {css(:popover)}>
            <h3 {css(:popover_title)}>Hello!</h3>
            <p {css(:popover_text)}>
              This is a native HTML popover. It automatically positions itself and handles
              keyboard navigation. Click outside to dismiss.
            </p>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Manual Popover</.demo_section_title>
        <.demo_section_description>
          This popover uses
          <.code_inline>popover="manual"</.code_inline>
          and requires explicit closing.
          Great for confirmation dialogs.
        </.demo_section_description>

        <div {css(:demo_row)}>
          <.button variant={:secondary} popovertarget="manual-popover">
            Confirm Action
          </.button>

          <div id="manual-popover" popover="manual" {css(:manual_popover)}>
            <div {css(:popover_header)}>
              <h3 {css(:popover_title)}>Confirm Delete</h3>
              <button
                {css(:popover_close)}
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
            <p {css(:popover_text)}>
              Are you sure you want to delete this item? This action cannot be undone.
            </p>
            <div {css(:popover_actions)}>
              <.button
                variant={:secondary}
                popovertarget="manual-popover"
                popovertargetaction="hide"
              >
                Cancel
              </.button>
              <.button
                variant={:danger}
                popovertarget="manual-popover"
                popovertargetaction="hide"
              >
                Delete
              </.button>
            </div>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Menu Popover</.demo_section_title>
        <.demo_section_description>
          Dropdown menus are a perfect use case for popovers. They get proper focus management
          and dismiss behavior for free.
        </.demo_section_description>

        <div {css(:demo_row)}>
          <.button
            variant={:secondary}
            {css(:menu_trigger)}
            popovertarget="menu-popover"
          >
            Options ▾
          </.button>

          <div
            id="menu-popover"
            popover="auto"
            {css(:menu_position)}
          >
            <.menu>
              <.menu_item popovertarget="menu-popover" popovertargetaction="hide">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                  />
                </svg>
                Edit
              </.menu_item>

              <.menu_item popovertarget="menu-popover" popovertargetaction="hide">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"
                  />
                </svg>
                Duplicate
              </.menu_item>

              <.menu_item popovertarget="menu-popover" popovertargetaction="hide">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"
                  />
                </svg>
                Archive
              </.menu_item>

              <.menu_divider />

              <.menu_item danger popovertarget="menu-popover" popovertargetaction="hide">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                  />
                </svg>
                Delete
              </.menu_item>
            </.menu>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Toast Notification</.demo_section_title>
        <.demo_section_description>
          Popovers can be positioned anywhere and styled as notifications.
          They appear in the top layer, above all other content.
        </.demo_section_description>

        <div {css(:demo_row)}>
          <.button variant={:primary} popovertarget="toast-success">
            Show Success Toast
          </.button>
        </div>

        <div id="toast-success" popover="auto" {css(:toast_position)}>
          <.toast variant={:success}>
            Changes saved successfully!
            <:actions>
              <button
                type="button"
                {css(:toast_close)}
                popovertarget="toast-success"
                popovertargetaction="hide"
                aria-label="close"
              >
                <.icon name="close" size={:sm} />
              </button>
            </:actions>
          </.toast>
        </div>
      </.demo_section>
    </.shell>
    """
  end
end
