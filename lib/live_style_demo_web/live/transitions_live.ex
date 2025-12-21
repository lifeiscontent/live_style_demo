defmodule LiveStyleDemoWeb.TransitionsLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.BaseStyles

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
      animation_duration: ".4s",
      animation_timing_function: "cubic-bezier(0.4, 0, 0.2, 1)"
    ]
  )

  css_view_transition(:list_item,
    group: [
      animation_duration: ".3s",
      animation_timing_function: "ease-out"
    ]
  )

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

  # ============================================================================
  # Demo 1: Card Grid with View Transitions
  # ============================================================================

  css_class(:demo_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fill, minmax(200px, 1fr))",
    gap: css_const({Tokens, :space, :"4"})
  )

  css_class(:card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_const({Tokens, :space, :"4"}),
    cursor: "pointer",
    transition: "opacity 0.3s ease-out, transform 0.3s ease-out, box-shadow 0.2s ease",
    opacity: %{
      :default => "1",
      "@starting-style" => "0"
    },
    transform: %{
      :default => "scale(1)",
      ":hover" => "scale(1.02)",
      "@starting-style" => "scale(0.9)"
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
    margin_bottom: css_const({Tokens, :space, :"1"})
  )

  css_class(:card_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  css_class(:button_row,
    display: "flex",
    gap: css_const({Tokens, :space, :"2"}),
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  # ============================================================================
  # Demo 2: Todo List with View Transitions
  # ============================================================================

  css_class(:todo_container,
    max_width: "400px"
  )

  css_class(:todo_input_wrapper,
    display: "flex",
    gap: css_const({Tokens, :space, :"2"}),
    margin_bottom: css_const({Tokens, :space, :"4"})
  )

  css_class(:todo_input,
    flex: "1",
    padding: "10px 12px",
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
      ":focus" => css_var({Tokens, :colors, :indigo_500})
    }
  )

  css_class(:todo_list,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    overflow: "hidden"
  )

  css_class(:todo_item,
    display: "flex",
    align_items: "center",
    gap: css_const({Tokens, :space, :"3"}),
    padding: css_const({Tokens, :space, :"3"}),
    border_bottom: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle})
  )

  css_class(:todo_item_last,
    border_bottom: "none"
  )

  css_class(:todo_checkbox,
    width: "20px",
    height: "20px",
    accent_color: css_var({Tokens, :colors, :indigo_600}),
    cursor: "pointer"
  )

  css_class(:todo_text,
    flex: "1",
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:todo_text_done,
    text_decoration: "line-through",
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:todo_delete,
    padding: "4px",
    background: "none",
    border: "none",
    cursor: "pointer",
    color: css_var({Tokens, :semantic, :text_muted}),
    border_radius: css_const({Tokens, :radius, :sm}),
    transition: "color 0.15s ease",
    color: %{
      :default => css_var({Tokens, :semantic, :text_muted}),
      ":hover" => css_var({Tokens, :colors, :red_600})
    }
  )

  css_class(:empty_state,
    padding: css_const({Tokens, :space, :"8"}),
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
       todos: initial_todos(),
       new_todo: ""
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

  defp initial_todos do
    [
      %{id: 1, text: "Learn View Transitions", done: false},
      %{id: 2, text: "Build a demo", done: true},
      %{id: 3, text: "Share with team", done: false}
    ]
  end

  # Event handlers - no push_event needed!
  # With animate: "always" mode, all DOM patches are automatically
  # wrapped in view transitions. Elements with view-transition-name
  # will animate smoothly.

  @impl true
  def handle_event("shuffle_cards", _params, socket) do
    {:noreply, assign(socket, cards: Enum.shuffle(socket.assigns.cards))}
  end

  @impl true
  def handle_event("add_card", _params, socket) do
    max_id = socket.assigns.cards |> Enum.map(& &1.id) |> Enum.max(fn -> 0 end)
    new_card = %{id: max_id + 1, title: "Card #{max_id + 1}", text: "New card"}
    {:noreply, assign(socket, cards: socket.assigns.cards ++ [new_card])}
  end

  @impl true
  def handle_event("remove_card", %{"id" => id}, socket) do
    id = String.to_integer(id)
    cards = Enum.reject(socket.assigns.cards, &(&1.id == id))
    {:noreply, assign(socket, cards: cards)}
  end

  @impl true
  def handle_event("update_new_todo", %{"text" => text}, socket) do
    {:noreply, assign(socket, new_todo: text)}
  end

  @impl true
  def handle_event("add_todo", %{"text" => text}, socket) do
    text = String.trim(text)

    if text != "" do
      max_id = socket.assigns.todos |> Enum.map(& &1.id) |> Enum.max(fn -> 0 end)
      new_todo = %{id: max_id + 1, text: text, done: false}
      {:noreply, assign(socket, todos: [new_todo | socket.assigns.todos], new_todo: "")}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("toggle_todo", %{"id" => id}, socket) do
    id = String.to_integer(id)

    todos =
      Enum.map(socket.assigns.todos, fn todo ->
        if todo.id == id, do: %{todo | done: not todo.done}, else: todo
      end)

    {:noreply, assign(socket, todos: todos)}
  end

  @impl true
  def handle_event("delete_todo", %{"id" => id}, socket) do
    id = String.to_integer(id)
    todos = Enum.reject(socket.assigns.todos, &(&1.id == id))
    {:noreply, assign(socket, todos: todos)}
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
          <h1 class={css_class([:page_title])}>View Transitions</h1>
          <div></div>
        </div>
      </header>

      <main class={css_class([:main])}>
        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Card Grid</h2>
          <p class={css_class([:section_description])}>
            Cards use <code class={css_class([:code_inline])}>view-transition-name</code> to create
            smooth animations when shuffled, added, or removed. Each card gets a unique transition name.
          </p>

          <div class={css_class([:browser_note])}>
            <span>⚠️</span>
            <span>Requires Chrome 111+ or Safari 18+ with View Transitions support</span>
          </div>

          <div class={css_class([:button_row])} style="margin-top: 1rem;">
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

        <section class={css_class([:section])}>
          <h2 class={css_class([:section_title])}>Todo List</h2>
          <p class={css_class([:section_description])}>
            Todo items animate in and out using view transitions. Add, complete, and delete todos
            to see the animations in action.
          </p>

          <div class={css_class([:todo_container])}>
            <form phx-submit="add_todo" class={css_class([:todo_input_wrapper])}>
              <input
                type="text"
                name="text"
                class={css_class([:todo_input])}
                placeholder="Add a new todo..."
                value={@new_todo}
                phx-change="update_new_todo"
              />
              <button
                type="submit"
                class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}
              >
                Add
              </button>
            </form>

            <div id="todo-list" class={css_class([:todo_list])}>
              <%= if @todos == [] do %>
                <div class={css_class([:empty_state])}>
                  No todos yet. Add one above!
                </div>
              <% else %>
                <%= for {todo, index} <- Enum.with_index(@todos) do %>
                  <.view_transition
                    id={"todo-#{todo.id}"}
                    class={css_class([:todo_item, index == length(@todos) - 1 && :todo_item_last])}
                    view-transition-class={css_view_transition(:list_item)}
                  >
                    <input
                      type="checkbox"
                      class={css_class([:todo_checkbox])}
                      checked={todo.done}
                      phx-click="toggle_todo"
                      phx-value-id={todo.id}
                    />
                    <span class={css_class([:todo_text]) <> if(todo.done, do: " " <> css_class([:todo_text_done]), else: "")}>
                      {todo.text}
                    </span>
                    <button
                      class={css_class([:todo_delete])}
                      phx-click="delete_todo"
                      phx-value-id={todo.id}
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
      </main>
    </div>
    """
  end
end
