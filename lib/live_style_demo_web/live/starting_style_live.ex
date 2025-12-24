defmodule LiveStyleDemoWeb.StartingStyleLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  css_class(:button_row,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_var({Tokens, :space, :"2"}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:button_row_top,
    margin_top: css_var({Tokens, :space, :"4"})
  )

  css_class(:empty_hint,
    color: css_var({Tokens, :semantic, :text_muted}),
    text_align: "center",
    padding_top: css_var({Tokens, :space, :"16"})
  )

  # ============================================================================
  # Demo 1: Entry Animation with @starting-style
  # ============================================================================

  css_class(:demo_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fill, minmax(200px, 1fr))",
    gap: css_var({Tokens, :space, :"4"})
  )

  # Card with @starting-style for entry animation
  # The card starts invisible and scales down, then transitions to visible
  css_class(:animated_card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"4"}),
    cursor: "pointer",
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
    margin_bottom: css_var({Tokens, :space, :"1"})
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
    gap: css_var({Tokens, :space, :"4"})
  )

  # Layout concern: where the modal appears.
  css_class(:modal_center,
    position: "fixed",
    inset: "0",
    width: "fit-content",
    height: "fit-content",
    margin: "auto"
  )

  css_class(:modal_popover,
    transition: "opacity 0.25s ease, transform 0.25s ease, display 0.25s allow-discrete",
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
    "::backdrop": %{
      background_color: css_var({Tokens, :semantic, :overlay_backdrop}),
      backdrop_filter: "blur(4px)",
      transition: "opacity 0.25s ease"
    }
  )

  # ============================================================================
  # Demo 3: Notification with @starting-style
  # ============================================================================

  css_class(:notification_area,
    position: "relative",
    min_height: "200px",
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"4"}),
    overflow: "hidden"
  )

  css_class(:notification_container,
    position: "absolute",
    bottom: css_var({Tokens, :space, :"4"}),
    right: css_var({Tokens, :space, :"4"}),
    display: "flex",
    flex_direction: "column",
    gap: css_var({Tokens, :space, :"2"})
  )

  css_class(:notification,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
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
    background_color: css_var({Tokens, :semantic, :fill_success})
  )

  css_class(:notification_error,
    background_color: css_var({Tokens, :semantic, :fill_danger})
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
    padding: css_var({Tokens, :space, :"1"}),
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
    <.shell
      active="starting-style"
      page_title="@starting-style"
      page_subtitle="First-render transitions, no JS required."
    >
      <.demo_section>
        <.demo_section_title>Entry Animations</.demo_section_title>
        <.demo_section_description>
          <.code_inline>@starting-style</.code_inline>
          defines the initial state
          for CSS transitions when an element is first rendered. This enables smooth entry animations
          without JavaScript.
        </.demo_section_description>

        <.browser_note>
          <span>⚠️</span>
          <span>Requires Chrome 117+ or Safari 17.4+ with @starting-style support</span>
        </.browser_note>

        <div class={css_class([:button_row, :button_row_top])}>
          <.button variant={:primary} phx-click="add_card">
            Add Card
          </.button>
          <.button variant={:secondary} phx-click="clear_cards">
            Clear All
          </.button>
        </div>

        <div class={css_class([:demo_grid])}>
          <%= for card <- @cards do %>
            <div
              class={css_class([:animated_card])}
              phx-click="remove_card"
              phx-value-id={card.id}
            >
              <h3 class={css_class([:card_title])}>{card.title}</h3>
              <p class={css_class([:card_text])}>Click to remove</p>
            </div>
          <% end %>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Dialog Animation</.demo_section_title>
        <.demo_section_description>
          Dialogs can use
          <.code_inline>@starting-style</.code_inline>
          with
          <.code_inline>transition-behavior: allow-discrete</.code_inline>
          to animate from <.code_inline>display: none</.code_inline>.
        </.demo_section_description>

        <div class={css_class([:dialog_wrapper])}>
          <.button variant={:primary} popovertarget="animated-dialog">
            Open Dialog
          </.button>
        </div>

        <div id="animated-dialog" popover="auto" class={css_class([:modal_center, :modal_popover])}>
          <.modal title="Animated Dialog">
            <p>
              This dialog fades and slides in when opened, and fades out when closed.
              The animation is powered entirely by CSS using @starting-style.
            </p>

            <:actions>
              <.button
                variant={:secondary}
                popovertarget="animated-dialog"
                popovertargetaction="hide"
              >
                Close
              </.button>
              <.button
                variant={:primary}
                popovertarget="animated-dialog"
                popovertargetaction="hide"
              >
                Confirm
              </.button>
            </:actions>
          </.modal>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Toast Notifications</.demo_section_title>
        <.demo_section_description>
          Notifications slide in from the right using @starting-style. They auto-dismiss after 3 seconds.
        </.demo_section_description>

        <div class={css_class([:button_row])}>
          <.button variant={:primary} phx-click="add_notification" phx-value-type="success">
            Success Toast
          </.button>
          <.button variant={:danger} phx-click="add_notification" phx-value-type="error">
            Error Toast
          </.button>
        </div>

        <div class={css_class([:notification_area])}>
          <p class={css_class([:empty_hint])}>Click a button above to show a notification</p>

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
      </.demo_section>
    </.shell>
    """
  end
end
