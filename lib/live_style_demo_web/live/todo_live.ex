defmodule LiveStyleDemoWeb.TodoLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  import LiveStyleDemoWeb.ViewTransition

  # ============================================================================
  # Keyframes
  # ============================================================================

  keyframes(:check_bounce,
    "0%": [transform: "scale(1)"],
    "50%": [transform: "scale(1.2)"],
    "100%": [transform: "scale(1)"]
  )

  keyframes(:strike_through,
    from: [width: "0%"],
    to: [width: "100%"]
  )

  keyframes(:shake,
    "0%, 100%": [transform: "translateX(0)"],
    "25%": [transform: "translateX(-5px)"],
    "75%": [transform: "translateX(5px)"]
  )

  # ============================================================================
  # View Transitions
  # ============================================================================

  view_transition(:todo_item,
    group: [
      pointer_events: "none",
      animation_duration: ".22s",
      animation_timing_function: "ease-out"
    ]
  )

  # ============================================================================
  # Layout
  # ============================================================================

  class(:content,
    padding_top: var({Space, :"8"}),
    padding_bottom: var({Space, :"16"})
  )

  class(:container,
    max_width: "32rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: var({Space, :"6"}),
    padding_right: var({Space, :"6"})
  )

  # ============================================================================
  # Card
  # ============================================================================

  class(:card,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  class(:card_header,
    background: var({Semantic, :fill_primary}),
    padding: var({Space, :"6"}),
    color: var({Semantic, :text_on_primary})
  )

  class(:card_title,
    font_size: const({Tokens, :font_size_2xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    margin: "0",
    display: "flex",
    align_items: "center",
    gap: var({Space, :"3"})
  )

  class(:card_subtitle,
    font_size: const({Tokens, :font_size_sm}),
    opacity: "0.9",
    margin_top: var({Space, :"1"})
  )

  class(:card_body,
    padding: var({Space, :"6"})
  )

  # ============================================================================
  # Input Form
  # ============================================================================

  class(:form,
    display: "flex",
    gap: var({Space, :"3"}),
    margin_bottom: var({Space, :"6"})
  )

  # Using BaseStyles for input and button, just need local overrides if any

  # ============================================================================
  # Task List
  # ============================================================================

  class(:todo_list,
    list_style: "none",
    padding: "0",
    margin: "0"
  )

  class(:todo_item,
    display: "flex",
    align_items: "center",
    gap: var({Space, :"3"}),
    padding: var({Space, :"4"}),
    border_radius: const({Tokens, :radius_lg}),
    margin_bottom: var({Space, :"2"}),
    background_color: var({Semantic, :fill_surface}),
    border: "1px solid #{var({Semantic, :border_subtle})}",
    transition: "background-color 0.2s ease",
    contain: "layout"
  )

  class(:todo_item_completed,
    opacity: "0.75",
    background_color:
      "color-mix(in oklab, #{var({Semantic, :fill_success})} 14%, #{var({Semantic, :fill_surface})})"
  )

  # ============================================================================
  # Checkbox (Delegated to BaseStyles, but we need local helper for logic)
  # ============================================================================

  # We use the BaseStyles classes directly in the render function

  # ============================================================================
  # Item Text
  # ============================================================================

  class(:todo_text_wrapper,
    flex: "1",
    position: "relative",
    overflow: "hidden"
  )

  class(:todo_text,
    font_size: const({Tokens, :font_size_base}),
    color: var({Semantic, :text_primary}),
    transition: "color 0.2s ease"
  )

  class(:todo_text_completed,
    color: var({Semantic, :text_muted})
  )

  class(:todo_strike,
    position: "absolute",
    top: "50%",
    left: "0",
    height: "2px",
    background_color: var({Semantic, :text_muted}),
    animation_name: keyframes(:strike_through),
    animation_duration: "0.3s",
    animation_timing_function: "ease-out",
    animation_fill_mode: "forwards"
  )

  # ============================================================================
  # Delete Button
  # ============================================================================

  class(:delete_button,
    width: "2rem",
    height: "2rem",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    border_radius: const({Tokens, :radius_full}),
    color: [
      default: var({Semantic, :text_muted}),
      ":hover": var({Semantic, :fill_danger})
    ],
    background_color: [
      default: "transparent",
      ":hover": "color-mix(in oklab, #{var({Semantic, :fill_danger})} 12%, transparent)"
    ],
    border: "none",
    font_size: const({Tokens, :font_size_lg}),
    opacity: "0",
    transform: "scale(0.8)",
    transition: "all 0.2s ease",
    cursor: "pointer"
  )

  # ============================================================================
  # Empty State
  # ============================================================================

  class(:empty_state,
    text_align: "center",
    padding: var({Space, :"8"}),
    color: var({Semantic, :text_muted})
  )

  class(:empty_icon,
    font_size: "3rem",
    margin_bottom: var({Space, :"4"}),
    opacity: "0.5"
  )

  class(:empty_text,
    font_size: const({Tokens, :font_size_lg}),
    margin_bottom: var({Space, :"2"})
  )

  class(:empty_subtext,
    font_size: const({Tokens, :font_size_sm})
  )

  # ============================================================================
  # Filter Buttons
  # ============================================================================

  class(:filter_group,
    display: "flex",
    flex_wrap: "wrap",
    justify_content: "center",
    gap: var({Space, :"2"}),
    margin_bottom: var({Space, :"4"})
  )

  class(:filter_button,
    padding_top: var({Space, :"2"}),
    padding_bottom: var({Space, :"2"}),
    padding_left: [
      default: var({Space, :"4"}),
      "@media (max-width: 420px)": var({Space, :"3"})
    ],
    padding_right: [
      default: var({Space, :"4"}),
      "@media (max-width: 420px)": var({Space, :"3"})
    ],
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    background_color: "transparent",
    border_width: "1px",
    border_style: "solid",
    border_color: var({Semantic, :border_default}),
    border_radius: const({Tokens, :radius_full}),
    cursor: "pointer",
    transition: "all 0.2s ease"
  )

  class(:filter_button_active,
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    border_color: "transparent"
  )

  # ============================================================================
  # Input Shake Animation
  # ============================================================================

  class(:input_shake,
    animation_name: keyframes(:shake),
    animation_duration: "0.4s",
    animation_timing_function: "ease-out",
    border_color: [
      default: var({Semantic, :fill_danger}),
      ":focus": var({Semantic, :fill_danger})
    ]
  )

  # ============================================================================
  # Footer Stats
  # ============================================================================

  class(:footer,
    display: "flex",
    justify_content: "space-between",
    align_items: "center",
    padding_top: var({Space, :"4"}),
    border_top_width: "1px",
    border_top_style: "solid",
    border_top_color: var({Semantic, :border_subtle}),
    margin_top: var({Space, :"4"})
  )

  class(:stats,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_muted})
  )

  class(:clear_button,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_muted}),
    background: "none",
    border: "none",
    cursor: "pointer",
    text_decoration: "none"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    todos = [
      %{id: 1, text: "Build a todo app with LiveStyle", completed: true},
      %{id: 2, text: "Add smooth animations", completed: true},
      %{id: 3, text: "Implement view transitions", completed: false},
      %{id: 4, text: "Share with the world", completed: false}
    ]

    {:ok,
     socket
     |> assign(
       page_title: "Todo Demo",
       todos: todos,
       new_todo: "",
       next_id: 5,
       filter: :all,
       input_error: false
     )}
  end

  # Event handlers - no push_event needed!
  # With animate: "always" mode, all DOM patches are automatically
  # wrapped in view transitions.

  @impl true
  def handle_event("update_input", %{"text" => text}, socket) do
    {:noreply, assign(socket, new_todo: text)}
  end

  @impl true
  def handle_event("add_todo", %{"text" => text}, socket) do
    text = String.trim(text)

    if text == "" do
      {:noreply,
       socket
       |> assign(input_error: true)
       |> push_event("shake-input", %{})}
    else
      new_todo = %{
        id: socket.assigns.next_id,
        text: text,
        completed: false
      }

      {:noreply,
       assign(socket,
         todos: socket.assigns.todos ++ [new_todo],
         new_todo: "",
         next_id: socket.assigns.next_id + 1,
         input_error: false
       )}
    end
  end

  @impl true
  def handle_event("clear_input_error", _params, socket) do
    {:noreply, assign(socket, input_error: false)}
  end

  @impl true
  def handle_event("set_filter", %{"filter" => filter}, socket) do
    {:noreply, assign(socket, filter: String.to_existing_atom(filter))}
  end

  @impl true
  def handle_event("toggle_todo", %{"id" => id}, socket) do
    id = String.to_integer(id)

    todos =
      Enum.map(socket.assigns.todos, fn todo ->
        if todo.id == id do
          %{todo | completed: not todo.completed}
        else
          todo
        end
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
  def handle_event("clear_completed", _params, socket) do
    todos = Enum.reject(socket.assigns.todos, & &1.completed)
    {:noreply, assign(socket, todos: todos)}
  end

  # ============================================================================
  # Helpers
  # ============================================================================

  defp items_left(todos) do
    Enum.count(todos, &(not &1.completed))
  end

  defp completed_count(todos) do
    Enum.count(todos, & &1.completed)
  end

  defp filtered_todos(todos, :all), do: todos
  defp filtered_todos(todos, :active), do: Enum.filter(todos, &(not &1.completed))
  defp filtered_todos(todos, :completed), do: Enum.filter(todos, & &1.completed)

  # ============================================================================
  # Render
  # ============================================================================

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="todo"
      page_title="Todo App"
      page_subtitle="A small LiveView app: transitions, hooks, and component styling."
    >
      <div id="todo-page">
        <div {css(:content)}>
          <div {css(:container)}>
            <div {css(:card)}>
              <%!-- Header --%>
              <div {css(:card_header)}>
                <h1 {css(:card_title)}>
                  <span>&#9745;</span> Todo List
                </h1>
                <p {css(:card_subtitle)}>
                  Built with LiveStyle &amp; View Transitions API
                </p>
              </div>

              <div {css(:card_body)}>
                <%!-- Input Form --%>
                <form phx-submit="add_todo" {css(:form)}>
                  <.input
                    name="text"
                    value={@new_todo}
                    placeholder="What needs to be done?"
                    phx-change="update_input"
                    phx-hook=".ShakeInput"
                    id="todo-input"
                    autocomplete="off"
                    error={@input_error}
                    {css([@input_error && :input_shake])}
                  />
                  <.button type="submit" variant={:primary}>Add</.button>
                </form>

                <%!-- Filter Buttons --%>
                <%= if not Enum.empty?(@todos) do %>
                  <div {css(:filter_group)}>
                    <button
                      type="button"
                      phx-click="set_filter"
                      phx-value-filter="all"
                      {css([:filter_button, @filter == :all && :filter_button_active])}
                    >
                      All
                    </button>
                    <button
                      type="button"
                      phx-click="set_filter"
                      phx-value-filter="active"
                      {css([:filter_button, @filter == :active && :filter_button_active])}
                    >
                      Active
                    </button>
                    <button
                      type="button"
                      phx-click="set_filter"
                      phx-value-filter="completed"
                      {css([:filter_button, @filter == :completed && :filter_button_active])}
                    >
                      Completed
                    </button>
                  </div>
                <% end %>

                <%!-- Todo List --%>
                <%= if Enum.empty?(@todos) do %>
                  <div {css(:empty_state)}>
                    <div {css(:empty_icon)}>&#128203;</div>
                    <p {css(:empty_text)}>No todos yet!</p>
                    <p {css(:empty_subtext)}>Add one above to get started</p>
                  </div>
                <% else %>
                  <ul {css(:todo_list)}>
                    <%= for todo <- filtered_todos(@todos, @filter) do %>
                      <.view_transition
                        id={"todo-#{todo.id}"}
                        {css([:todo_item, todo.completed && :todo_item_completed])}
                        view-transition-class={view_transition_class(:todo_item)}
                      >
                        <%!-- Checkbox --%>
                        <.input
                          type="checkbox"
                          checked={todo.completed}
                          phx-click="toggle_todo"
                          phx-value-id={todo.id}
                          aria-label="Toggle todo"
                        />

                        <%!-- Text --%>
                        <div {css(:todo_text_wrapper)}>
                          <span {css([:todo_text, todo.completed && :todo_text_completed])}>
                            {todo.text}
                          </span>
                          <%= if todo.completed do %>
                            <div {css(:todo_strike)}></div>
                          <% end %>
                        </div>

                        <%!-- Delete Button --%>
                        <button
                          type="button"
                          phx-click="delete_todo"
                          phx-value-id={todo.id}
                          {css(:delete_button)}
                          aria-label="Delete todo"
                        >
                          &#10005;
                        </button>
                      </.view_transition>
                    <% end %>
                  </ul>

                  <%!-- Footer --%>
                  <div {css(:footer)}>
                    <span {css(:stats)}>
                      {items_left(@todos)} item{if items_left(@todos) != 1, do: "s"} left
                    </span>
                    <%= if completed_count(@todos) > 0 do %>
                      <button
                        type="button"
                        phx-click="clear_completed"
                        {css(:clear_button)}
                      >
                        Clear completed ({completed_count(@todos)})
                      </button>
                    <% end %>
                  </div>
                <% end %>
              </div>
            </div>
          </div>
        </div>
      </div>

      <%!-- Colocated Hooks --%>
      <script :type={Phoenix.LiveView.ColocatedHook} name=".ShakeInput">
        export default {
          mounted() {
            this.handleEvent("shake-input", () => {
              this.el.focus()
              this.el.addEventListener("animationend", () => {
                this.pushEvent("clear_input_error", {})
              }, { once: true })
            })
          }
        }
      </script>
    </.shell>
    """
  end
end
