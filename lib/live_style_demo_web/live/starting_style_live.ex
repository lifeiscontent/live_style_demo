defmodule LiveStyleDemoWeb.StartingStyleLive do
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

  css_class(:button_row,
    display: "flex",
    gap: css_const({Tokens, :space, :"2"}),
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  # ============================================================================
  # Demo 1: Entry Animation with @starting-style
  # ============================================================================

  css_class(:demo_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fill, minmax(200px, 1fr))",
    gap: css_const({Tokens, :space, :"4"})
  )

  # Card with @starting-style for entry animation
  # The card starts invisible and scales down, then transitions to visible
  css_class(:animated_card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"4"}),
    # Transition properties for smooth animation
    transition: "opacity 0.3s ease, transform 0.3s ease",
    # Default (end) state
    opacity: %{
      :default => "1",
      "@starting-style" => "0"
    },
    transform: %{
      :default => "scale(1)",
      "@starting-style" => "scale(0.9)"
    }
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :base}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"1"})
  )

  css_class(:card_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  # ============================================================================
  # Demo 2: Dialog with @starting-style
  # ============================================================================

  css_class(:dialog_wrapper,
    display: "flex",
    gap: css_const({Tokens, :space, :"4"})
  )

  # Dialog using popover with @starting-style
  css_class(:dialog,
    padding: css_const({Tokens, :space, :"6"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    max_width: "400px",
    # Center the dialog
    position: "fixed",
    inset: "0",
    width: "fit-content",
    height: "fit-content",
    margin: "auto",
    # Transition for smooth open/close
    transition: "opacity 0.25s ease, transform 0.25s ease, display 0.25s allow-discrete",
    # End state (open)
    opacity: %{
      :default => "1",
      ":not(:popover-open)" => "0",
      "@starting-style" => "0"
    },
    transform: %{
      :default => "translateY(0)",
      ":not(:popover-open)" => "translateY(-10px)",
      "@starting-style" => "translateY(-10px)"
    },
    # Backdrop
    "::backdrop": %{
      background_color: "rgba(0, 0, 0, 0.3)",
      backdrop_filter: "blur(4px)",
      transition: "opacity 0.25s ease"
    }
  )

  css_class(:dialog_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_const({Tokens, :space, :"2"})
  )

  css_class(:dialog_text,
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  css_class(:dialog_actions,
    display: "flex",
    gap: css_const({Tokens, :space, :"2"}),
    justify_content: "flex-end"
  )

  # ============================================================================
  # Demo 3: Notification with @starting-style
  # ============================================================================

  css_class(:notification_area,
    position: "relative",
    min_height: "200px",
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"4"}),
    overflow: "hidden"
  )

  css_class(:notification_container,
    position: "absolute",
    bottom: css_const({Tokens, :space, :"4"}),
    right: css_const({Tokens, :space, :"4"}),
    display: "flex",
    flex_direction: "column",
    gap: css_const({Tokens, :space, :"2"})
  )

  css_class(:notification,
    display: "flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"3"}),
    padding: css_const({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :colors, :gray_900}),
    color: css_var({Tokens, :colors, :white}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    min_width: "280px",
    # Transition
    transition: "opacity 0.3s ease, transform 0.3s ease",
    opacity: %{
      :default => "1",
      "@starting-style" => "0"
    },
    transform: %{
      :default => "translateX(0)",
      "@starting-style" => "translateX(100%)"
    }
  )

  css_class(:notification_success,
    background_color: css_var({Tokens, :colors, :green_600})
  )

  css_class(:notification_error,
    background_color: css_var({Tokens, :colors, :red_600})
  )

  css_class(:notification_icon,
    width: "20px",
    height: "20px",
    flex_shrink: "0"
  )

  css_class(:notification_text,
    flex: "1",
    font_size: css_const({Tokens, :font_size, :sm})
  )

  css_class(:notification_close,
    padding: "4px",
    background: "none",
    border: "none",
    cursor: "pointer",
    color: "inherit",
    border_radius: css_const({Tokens, :radius, :sm}),
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
    {:ok,
     assign(socket,
       page_title: "@starting-style",
       cards: [],
       notifications: [],
       next_card_id: 1,
       next_notification_id: 1
     )}
  end

  @impl true
  def handle_event("add_card", _params, socket) do
    new_card = %{id: socket.assigns.next_card_id, title: "Card #{socket.assigns.next_card_id}"}

    {:noreply,
     assign(socket,
       cards: socket.assigns.cards ++ [new_card],
       next_card_id: socket.assigns.next_card_id + 1
     )}
  end

  @impl true
  def handle_event("remove_card", %{"id" => id}, socket) do
    id = String.to_integer(id)
    cards = Enum.reject(socket.assigns.cards, &(&1.id == id))
    {:noreply, assign(socket, cards: cards)}
  end

  @impl true
  def handle_event("clear_cards", _params, socket) do
    {:noreply, assign(socket, cards: [])}
  end

  @impl true
  def handle_event("add_notification", %{"type" => type}, socket) do
    message =
      case type do
        "success" -> "Operation completed successfully!"
        "error" -> "Something went wrong. Please try again."
        _ -> "Notification message"
      end

    new_notification = %{
      id: socket.assigns.next_notification_id,
      type: type,
      message: message
    }

    # Auto-dismiss after 3 seconds
    Process.send_after(self(), {:dismiss_notification, new_notification.id}, 3000)

    {:noreply,
     assign(socket,
       notifications: socket.assigns.notifications ++ [new_notification],
       next_notification_id: socket.assigns.next_notification_id + 1
     )}
  end

  @impl true
  def handle_event("dismiss_notification", %{"id" => id}, socket) do
    id = String.to_integer(id)
    notifications = Enum.reject(socket.assigns.notifications, &(&1.id == id))
    {:noreply, assign(socket, notifications: notifications)}
  end

  @impl true
  def handle_info({:dismiss_notification, id}, socket) do
    notifications = Enum.reject(socket.assigns.notifications, &(&1.id == id))
    {:noreply, assign(socket, notifications: notifications)}
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
          <h1 class={css_class([:page_title])}>@starting-style</h1>
          <div></div>
        </div>
      </header>

      <main class={css_class([:main])}>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Entry Animations</h2>
          <p class={css_class([:section_description])}>
            <code class={css_class([:code_inline])}>@starting-style</code> defines the initial state
            for CSS transitions when an element is first rendered. This enables smooth entry animations
            without JavaScript.
          </p>

          <div class={css_class([:browser_note])}>
            <span>⚠️</span>
            <span>Requires Chrome 117+ or Safari 17.4+ with @starting-style support</span>
          </div>

          <div class={css_class([:button_row])} style="margin-top: 1rem;">
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
              phx-click="add_card"
            >
              Add Card
            </button>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
              phx-click="clear_cards"
            >
              Clear All
            </button>
          </div>

          <div class={css_class([:demo_grid])}>
            <%= for card <- @cards do %>
              <div
                class={css_class([:animated_card])}
                phx-click="remove_card"
                phx-value-id={card.id}
                style="cursor: pointer;"
              >
                <h3 class={css_class([:card_title])}>{card.title}</h3>
                <p class={css_class([:card_text])}>Click to remove</p>
              </div>
            <% end %>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Dialog Animation</h2>
          <p class={css_class([:section_description])}>
            Dialogs can use <code class={css_class([:code_inline])}>@starting-style</code>
            with <code class={css_class([:code_inline])}>transition-behavior: allow-discrete</code>
            to animate from <code class={css_class([:code_inline])}>display: none</code>.
          </p>

          <div class={css_class([:dialog_wrapper])}>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
              popovertarget="animated-dialog"
            >
              Open Dialog
            </button>
          </div>

          <div id="animated-dialog" popover="auto" class={css_class([:dialog])}>
            <h3 class={css_class([:dialog_title])}>Animated Dialog</h3>
            <p class={css_class([:dialog_text])}>
              This dialog fades and slides in when opened, and fades out when closed.
              The animation is powered entirely by CSS using @starting-style.
            </p>
            <div class={css_class([:dialog_actions])}>
              <button
                class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
                popovertarget="animated-dialog"
                popovertargetaction="hide"
              >
                Close
              </button>
              <button
                class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
                popovertarget="animated-dialog"
                popovertargetaction="hide"
              >
                Confirm
              </button>
            </div>
          </div>
        </section>

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Toast Notifications</h2>
          <p class={css_class([:section_description])}>
            Notifications slide in from the right using @starting-style. They auto-dismiss after 3 seconds.
          </p>

          <div class={css_class([:button_row])}>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
              phx-click="add_notification"
              phx-value-type="success"
            >
              Success Toast
            </button>
            <button
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
              phx-click="add_notification"
              phx-value-type="error"
              style="background-color: #dc2626; border-color: #dc2626; color: white;"
            >
              Error Toast
            </button>
          </div>

          <div class={css_class([:notification_area])}>
            <p style="color: #6b7280; text-align: center; padding-top: 4rem;">
              Click a button above to show a notification
            </p>

            <div class={css_class([:notification_container])}>
              <%= for notification <- @notifications do %>
                <div class={
                  css_class([
                    :notification,
                    String.to_existing_atom("notification_#{notification.type}")
                  ])
                }>
                  <svg
                    class={css_class([:notification_icon])}
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <%= if notification.type == "success" do %>
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M5 13l4 4L19 7"
                      />
                    <% else %>
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                      />
                    <% end %>
                  </svg>
                  <span class={css_class([:notification_text])}>{notification.message}</span>
                  <button
                    class={css_class([:notification_close])}
                    phx-click="dismiss_notification"
                    phx-value-id={notification.id}
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
              <% end %>
            </div>
          </div>
        </section>
      </main>
    </div>
    """
  end
end
