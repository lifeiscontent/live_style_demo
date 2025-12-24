defmodule LiveStyleDemoWeb.TodoLive do
  use LiveStyleDemoWeb, :live_view

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  import LiveStyleDemoWeb.ViewTransition

  # ============================================================================
  # Keyframes
  # ============================================================================

  css_keyframes(:check_bounce,
    "0%": [transform: "scale(1)"],
    "50%": [transform: "scale(1.2)"],
    "100%": [transform: "scale(1)"]
  )

  css_keyframes(:strike_through,
    from: [width: "0%"],
    to: [width: "100%"]
  )

  css_keyframes(:shake,
    "0%, 100%": [transform: "translateX(0)"],
    "25%": [transform: "translateX(-5px)"],
    "75%": [transform: "translateX(5px)"]
  )

  # ============================================================================
  # View Transitions
  # ============================================================================

  css_view_transition(:todo_item,
    group: [
      pointer_events: "none",
      animation_duration: ".22s",
      animation_timing_function: "ease-out"
    ]
  )

  # ============================================================================
  # Layout
  # ============================================================================

  css_class(:content,
    padding_top: css_var({Tokens, :space, :"8"}),
    padding_bottom: css_var({Tokens, :space, :"16"})
  )

  css_class(:container,
    max_width: "32rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"})
  )

  # ============================================================================
  # Card
  # ============================================================================

  css_class(:card,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  css_class(:card_header,
    background: css_var({Tokens, :semantic, :fill_primary}),
    padding: css_var({Tokens, :space, :"6"}),
    color: css_var({Tokens, :semantic, :text_on_primary})
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :"2xl"}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    margin: "0",
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"})
  )

  css_class(:card_subtitle,
    font_size: css_const({Tokens, :font_size, :sm}),
    opacity: "0.9",
    margin_top: css_var({Tokens, :space, :"1"})
  )

  css_class(:card_body,
    padding: css_var({Tokens, :space, :"6"})
  )

  # ============================================================================
  # Input Form
  # ============================================================================

  css_class(:form,
    display: "flex",
    gap: css_var({Tokens, :space, :"3"}),
    margin_bottom: css_var({Tokens, :space, :"6"})
  )

  # Using BaseStyles for input and button, just need local overrides if any

  # ============================================================================
  # Task List
  # ============================================================================

  css_class(:todo_list,
    list_style: "none",
    padding: "0",
    margin: "0"
  )

  css_class(:todo_item,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"}),
    border_radius: css_const({Tokens, :radius, :lg}),
    margin_bottom: css_var({Tokens, :space, :"2"}),
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_subtle})}",
    transition: "background-color 0.2s ease",
    contain: "layout"
  )

  css_class(:todo_item_completed,
    opacity: "0.75",
    background_color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_success})} 14%, #{css_var({Tokens, :semantic, :fill_surface})})"
  )

  # ============================================================================
  # Checkbox (Delegated to BaseStyles, but we need local helper for logic)
  # ============================================================================

  # We use the BaseStyles classes directly in the render function

  # ============================================================================
  # Item Text
  # ============================================================================

  css_class(:todo_text_wrapper,
    flex: "1",
    position: "relative",
    overflow: "hidden"
  )

  css_class(:todo_text,
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_primary}),
    transition: "color 0.2s ease"
  )

  css_class(:todo_text_completed,
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:todo_strike,
    position: "absolute",
    top: "50%",
    left: "0",
    height: "2px",
    background_color: css_var({Tokens, :semantic, :text_muted}),
    animation_name: css_keyframes(:strike_through),
    animation_duration: "0.3s",
    animation_timing_function: "ease-out",
    animation_fill_mode: "forwards"
  )

  # ============================================================================
  # Delete Button
  # ============================================================================

  css_class(:delete_button,
    width: "2rem",
    height: "2rem",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    border_radius: css_const({Tokens, :radius, :full}),
    color: [
      default: css_var({Tokens, :semantic, :text_muted}),
      ":hover": css_var({Tokens, :semantic, :fill_danger})
    ],
    background_color: [
      default: "transparent",
      ":hover":
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 12%, transparent)"
    ],
    border: "none",
    font_size: css_const({Tokens, :font_size, :lg}),
    opacity: "0",
    transform: "scale(0.8)",
    transition: "all 0.2s ease",
    cursor: "pointer"
  )

  # ============================================================================
  # Empty State
  # ============================================================================

  css_class(:empty_state,
    text_align: "center",
    padding: css_var({Tokens, :space, :"8"}),
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:empty_icon,
    font_size: "3rem",
    margin_bottom: css_var({Tokens, :space, :"4"}),
    opacity: "0.5"
  )

  css_class(:empty_text,
    font_size: css_const({Tokens, :font_size, :lg}),
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_class(:empty_subtext,
    font_size: css_const({Tokens, :font_size, :sm})
  )

  # ============================================================================
  # Filter Buttons
  # ============================================================================

  css_class(:filter_group,
    display: "flex",
    flex_wrap: "wrap",
    justify_content: "center",
    gap: css_var({Tokens, :space, :"2"}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:filter_button,
    padding_top: css_var({Tokens, :space, :"2"}),
    padding_bottom: css_var({Tokens, :space, :"2"}),
    padding_left: [
      default: css_var({Tokens, :space, :"4"}),
      "@media (max-width: 420px)": css_var({Tokens, :space, :"3"})
    ],
    padding_right: [
      default: css_var({Tokens, :space, :"4"}),
      "@media (max-width: 420px)": css_var({Tokens, :space, :"3"})
    ],
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    background_color: "transparent",
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_default}),
    border_radius: css_const({Tokens, :radius, :full}),
    cursor: "pointer",
    transition: "all 0.2s ease"
  )

  css_class(:filter_button_active,
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
    border_color: "transparent"
  )

  # ============================================================================
  # Input Shake Animation
  # ============================================================================

  css_class(:input_shake,
    animation_name: css_keyframes(:shake),
    animation_duration: "0.4s",
    animation_timing_function: "ease-out",
    border_color: [
      default: css_var({Tokens, :semantic, :fill_danger}),
      ":focus": css_var({Tokens, :semantic, :fill_danger})
    ]
  )

  # ============================================================================
  # Footer Stats
  # ============================================================================

  css_class(:footer,
    display: "flex",
    justify_content: "space-between",
    align_items: "center",
    padding_top: css_var({Tokens, :space, :"4"}),
    border_top_width: "1px",
    border_top_style: "solid",
    border_top_color: css_var({Tokens, :semantic, :border_subtle}),
    margin_top: css_var({Tokens, :space, :"4"})
  )

  css_class(:stats,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:clear_button,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_muted}),
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
        <div class={css_class([:content])}>
          <div class={css_class([:container])}>
            <div class={css_class([:card])}>
              <%!-- Header --%>
              <div class={css_class([:card_header])}>
                <h1 class={css_class([:card_title])}>
                  <span>&#9745;</span> Todo List
                </h1>
                <p class={css_class([:card_subtitle])}>
                  Built with LiveStyle &amp; View Transitions API
                </p>
              </div>

              <div class={css_class([:card_body])}>
                <%!-- Input Form --%>
                <form phx-submit="add_todo" class={css_class([:form])}>
                  <.input
                    name="text"
                    value={@new_todo}
                    placeholder="What needs to be done?"
                    phx-change="update_input"
                    phx-hook=".ShakeInput"
                    id="todo-input"
                    autocomplete="off"
                    error={@input_error}
                    class={if @input_error, do: css_class([:input_shake])}
                  />
                  <.button type="submit" variant={:primary}>Add</.button>
                </form>

                <%!-- Filter Buttons --%>
                <%= if not Enum.empty?(@todos) do %>
                  <div class={css_class([:filter_group])}>
                    <button
                      type="button"
                      phx-click="set_filter"
                      phx-value-filter="all"
                      class={filter_button_class(@filter == :all)}
                    >
                      All
                    </button>
                    <button
                      type="button"
                      phx-click="set_filter"
                      phx-value-filter="active"
                      class={filter_button_class(@filter == :active)}
                    >
                      Active
                    </button>
                    <button
                      type="button"
                      phx-click="set_filter"
                      phx-value-filter="completed"
                      class={filter_button_class(@filter == :completed)}
                    >
                      Completed
                    </button>
                  </div>
                <% end %>

                <%!-- Todo List --%>
                <%= if Enum.empty?(@todos) do %>
                  <div class={css_class([:empty_state])}>
                    <div class={css_class([:empty_icon])}>&#128203;</div>
                    <p class={css_class([:empty_text])}>No todos yet!</p>
                    <p class={css_class([:empty_subtext])}>Add one above to get started</p>
                  </div>
                <% else %>
                  <ul class={css_class([:todo_list])}>
                    <%= for todo <- filtered_todos(@todos, @filter) do %>
                      <.view_transition
                        id={"todo-#{todo.id}"}
                        class={css_class([:todo_item, todo.completed && :todo_item_completed])}
                        view-transition-class={css_view_transition(:todo_item)}
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
                        <div class={css_class([:todo_text_wrapper])}>
                          <span class={todo_text_class(todo.completed)}>
                            {todo.text}
                          </span>
                          <%= if todo.completed do %>
                            <div class={css_class([:todo_strike])}></div>
                          <% end %>
                        </div>

                        <%!-- Delete Button --%>
                        <button
                          type="button"
                          phx-click="delete_todo"
                          phx-value-id={todo.id}
                          class={css_class([:delete_button]) <> " delete-button"}
                          aria-label="Delete todo"
                        >
                          &#10005;
                        </button>
                      </.view_transition>
                    <% end %>
                  </ul>

                  <%!-- Footer --%>
                  <div class={css_class([:footer])}>
                    <span class={css_class([:stats])}>
                      {items_left(@todos)} item{if items_left(@todos) != 1, do: "s"} left
                    </span>
                    <%= if completed_count(@todos) > 0 do %>
                      <button
                        type="button"
                        phx-click="clear_completed"
                        class={css_class([:clear_button])}
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

  defp todo_text_class(completed) do
    if completed do
      css_class([:todo_text, :todo_text_completed])
    else
      css_class([:todo_text])
    end
  end

  defp filter_button_class(active) do
    if active do
      css_class([:filter_button, :filter_button_active])
    else
      css_class([:filter_button])
    end
  end
end
