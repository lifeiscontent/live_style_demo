defmodule LiveStyleDemoWeb.TransitionsLive do
  use LiveStyleDemoWeb, :live_view

  require Logger

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  import LiveStyleDemoWeb.ViewTransition

  # ============================================================================
  # View Transitions
  # ============================================================================

  css_keyframes(:fade_in,
    from: %{opacity: "0"},
    to: %{opacity: "1"}
  )

  css_keyframes(:fade_out,
    from: %{opacity: "1"},
    to: %{opacity: "0"}
  )

  css_keyframes(:scale_in,
    from: %{opacity: "0", transform: "scale(0.8)"},
    to: %{opacity: "1", transform: "scale(1)"}
  )

  css_keyframes(:scale_out,
    from: %{opacity: "1", transform: "scale(1)"},
    to: %{opacity: "0", transform: "scale(0.8)"}
  )

  css_keyframes(:slide_in_from_right,
    from: %{opacity: "0", transform: "translateX(30px)"},
    to: %{opacity: "1", transform: "translateX(0)"}
  )

  css_keyframes(:slide_out_to_left,
    from: %{opacity: "1", transform: "translateX(0)"},
    to: %{opacity: "0", transform: "translateX(-30px)"}
  )

  # Card transition: smooth position animation for shuffling
  # Uses default crossfade for enter/exit
  css_view_transition(:card,
    group: [
      # Prevent transition pseudo-elements from swallowing clicks.
      pointer_events: "none",
      animation_duration: ".22s",
      animation_timing_function: "cubic-bezier(0.2, 0, 0.2, 1)"
    ]
  )

  css_view_transition(:list_item,
    group: [
      pointer_events: "none",
      animation_duration: ".18s",
      animation_timing_function: "ease-out"
    ]
  )

  # ============================================================================
  # Demo 1: Card Grid with View Transitions
  # ============================================================================

  css_class(:demo_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fill, minmax(200px, 1fr))",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"4"}),
    cursor: "pointer",
    transition: "transform 0.18s ease-out, box-shadow 0.18s ease",
    transform: %{
      :default => "scale(1)",
      ":hover" => "scale(1.02)"
    },
    box_shadow: %{
      :default => "none",
      ":hover" => css_const({Tokens, :shadow, :md})
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

  css_class(:button_row,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_var({Tokens, :space, :"2"}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:button_row_top,
    margin_top: css_var({Tokens, :space, :"4"})
  )

  # ============================================================================
  # Demo 2: Notification Feed (insert/delete/read)
  # ============================================================================

  css_class(:feed_container,
    max_width: "420px"
  )

  css_class(:feed_input_row,
    display: "flex",
    gap: css_var({Tokens, :space, :"2"}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:feed_input,
    flex: "1",
    padding_block: css_var({Tokens, :space, :"2.5"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :base}),
    outline: %{
      :default => nil,
      ":focus" => "none"
    },
    border_color: %{
      :default => css_var({Tokens, :semantic, :border_subtle}),
      ":focus" => css_var({Tokens, :semantic, :border_focus})
    }
  )

  css_class(:feed_list,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    overflow: "hidden"
  )

  css_class(:feed_item,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"3"}),
    border_bottom: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle})
  )

  css_class(:feed_item_last,
    border_bottom: "none"
  )

  css_class(:feed_toggle,
    width: "20px",
    height: "20px",
    accent_color: css_var({Tokens, :semantic, :fill_primary}),
    cursor: "pointer"
  )

  css_class(:feed_text,
    flex: "1",
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:feed_text_read,
    text_decoration: "line-through",
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:feed_delete,
    padding: css_var({Tokens, :space, :"1"}),
    background: "none",
    border: "none",
    cursor: "pointer",
    color: css_var({Tokens, :semantic, :text_muted}),
    border_radius: css_const({Tokens, :radius, :sm}),
    transition: "color 0.15s ease",
    color: %{
      :default => css_var({Tokens, :semantic, :text_muted}),
      ":hover" => css_var({Tokens, :semantic, :text_danger})
    }
  )

  css_class(:empty_state,
    padding: css_var({Tokens, :space, :"8"}),
    text_align: "center",
    color: css_var({Tokens, :semantic, :text_muted}),
    font_size: css_const({Tokens, :font_size, :sm})
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "View Transitions",
       cards: initial_cards(),
       messages: initial_messages(),
       new_message: "",
       focused_demo: :cards
     )}
  end

  defp initial_cards do
    [
      %{id: 1, title: "Card 1", text: "First card"},
      %{id: 2, title: "Card 2", text: "Second card"},
      %{id: 3, title: "Card 3", text: "Third card"},
      %{id: 4, title: "Card 4", text: "Fourth card"}
    ]
  end

  defp initial_messages do
    [
      %{id: 1, text: "Deploy finished successfully", read: false},
      %{id: 2, text: "New signup: designer@liveview.dev", read: true},
      %{id: 3, text: "CI is green — ship it", read: false}
    ]
  end

  defp perf_log? do
    System.get_env("LIVE_STYLE_DEMO_PERF") in ["1", "true"]
  end

  # Event handlers - no push_event needed!
  # With animate: "always" mode, all DOM patches are automatically
  # wrapped in view transitions. Elements with view-transition-name
  # will animate smoothly.

  @impl true
  def handle_event("shuffle_cards", _params, socket) do
    {:noreply, assign(socket, cards: Enum.shuffle(socket.assigns.cards), focused_demo: :cards)}
  end

  @impl true
  def handle_event("add_card", _params, socket) do
    started_us = System.monotonic_time(:microsecond)

    max_id = socket.assigns.cards |> Enum.map(& &1.id) |> Enum.max(fn -> 0 end)
    new_card = %{id: max_id + 1, title: "Card #{max_id + 1}", text: "New card"}

    socket = assign(socket, cards: socket.assigns.cards ++ [new_card], focused_demo: :cards)

    elapsed_ms = (System.monotonic_time(:microsecond) - started_us) / 1000

    if perf_log?() do
      Logger.info(
        "[perf] /transitions add_card handled in #{elapsed_ms}ms cards=#{length(socket.assigns.cards)}"
      )
    end

    :telemetry.execute([:live_style_demo, :transitions, :add_card], %{duration_ms: elapsed_ms}, %{
      cards: length(socket.assigns.cards)
    })

    {:noreply, socket}
  end

  @impl true
  def handle_event("remove_card", %{"id" => id}, socket) do
    id = String.to_integer(id)
    cards = Enum.reject(socket.assigns.cards, &(&1.id == id))
    {:noreply, assign(socket, cards: cards, focused_demo: :cards)}
  end

  @impl true
  def handle_event("update_new_message", %{"text" => text}, socket) do
    {:noreply, assign(socket, new_message: text, focused_demo: :feed)}
  end

  @impl true
  def handle_event("add_message", %{"text" => text}, socket) do
    text = String.trim(text)

    if text != "" do
      max_id = socket.assigns.messages |> Enum.map(& &1.id) |> Enum.max(fn -> 0 end)
      new_message = %{id: max_id + 1, text: text, read: false}

      {:noreply,
       assign(socket,
         messages: [new_message | socket.assigns.messages],
         new_message: "",
         focused_demo: :feed
       )}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("toggle_read", %{"id" => id}, socket) do
    id = String.to_integer(id)

    messages =
      Enum.map(socket.assigns.messages, fn message ->
        if message.id == id, do: %{message | read: not message.read}, else: message
      end)

    {:noreply, assign(socket, messages: messages, focused_demo: :feed)}
  end

  @impl true
  def handle_event("delete_message", %{"id" => id}, socket) do
    id = String.to_integer(id)
    messages = Enum.reject(socket.assigns.messages, &(&1.id == id))
    {:noreply, assign(socket, messages: messages, focused_demo: :feed)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="transitions"
      page_title="View Transitions"
      page_subtitle="A focused lab for the View Transitions API + LiveView patches."
    >
      <section class={css_class([{BaseStyles, :demo_section}])}>
        <h2 class={css_class([{BaseStyles, :demo_section_title}])}>Card Grid</h2>
        <p class={css_class([{BaseStyles, :demo_section_description}])}>
          Cards use
          <code class={css_class([{BaseStyles, :demo_code_inline}])}>view-transition-name</code>
          to create
          smooth animations when shuffled, added, or removed. Each card gets a unique transition name.
        </p>

        <div class={css_class([{BaseStyles, :demo_browser_note}])}>
          <span>⚠️</span>
          <span>Requires Chrome 111+ or Safari 18+ with View Transitions support</span>
        </div>

        <div class={css_class([:button_row, :button_row_top])}>
          <button
            class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
            phx-click="shuffle_cards"
          >
            Shuffle Cards
          </button>
          <button
            class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
            phx-click="add_card"
          >
            Add Card
          </button>
        </div>

        <div id="cards-grid" class={css_class([:demo_grid])}>
          <%= for card <- @cards do %>
            <.view_transition
              id={"card-#{card.id}"}
              class={css_class([:card])}
              view-transition-class={css_view_transition(:card)}
              phx-click="remove_card"
              phx-value-id={card.id}
            >
              <h3 class={css_class([:card_title])}>{card.title}</h3>
              <p class={css_class([:card_text])}>{card.text}</p>
            </.view_transition>
          <% end %>
        </div>
      </section>

      <section class={css_class([{BaseStyles, :demo_section}])}>
        <h2 class={css_class([{BaseStyles, :demo_section_title}])}>Notification Feed</h2>
        <p class={css_class([{BaseStyles, :demo_section_description}])}>
          A small “live list” demo: insert, delete, and toggle read state.
          Each row gets a stable transition name for smooth animations.
        </p>

        <div class={css_class([:feed_container])}>
          <form phx-submit="add_message" class={css_class([:feed_input_row])}>
            <input
              type="text"
              name="text"
              class={css_class([:feed_input])}
              placeholder="Add a notification…"
              value={@new_message}
              phx-change="update_new_message"
            />
            <button
              type="submit"
              class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
            >
              Add
            </button>
          </form>

          <div id="feed-list" class={css_class([:feed_list])}>
            <%= if @messages == [] do %>
              <div class={css_class([:empty_state])}>
                Nothing here yet. Add one above!
              </div>
            <% else %>
              <%= for {message, index} <- Enum.with_index(@messages) do %>
                <.view_transition
                  id={"message-#{message.id}"}
                  class={css_class([:feed_item, index == length(@messages) - 1 && :feed_item_last])}
                  view-transition-class={css_view_transition(:list_item)}
                >
                  <input
                    type="checkbox"
                    class={css_class([:feed_toggle])}
                    checked={message.read}
                    phx-click="toggle_read"
                    phx-value-id={message.id}
                    aria-label="Toggle read"
                  />
                  <span class={css_class([:feed_text]) <>
                      if(message.read, do: " " <> css_class([:feed_text_read]), else: "")}>
                    {message.text}
                  </span>
                  <button
                    class={css_class([:feed_delete])}
                    phx-click="delete_message"
                    phx-value-id={message.id}
                    aria-label="Delete message"
                  >
                    <svg
                      width="16"
                      height="16"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M6 18L18 6M6 6l12 12"
                      />
                    </svg>
                  </button>
                </.view_transition>
              <% end %>
            <% end %>
          </div>
        </div>
      </section>
    </.shell>
    """
  end
end
