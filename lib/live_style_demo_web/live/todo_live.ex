defmodule LiveStyleDemoWeb.TodoLive do
  use LiveStyleDemoWeb, :live_view
  use LiveStyle

  alias LiveStyleDemoWeb.BaseStyles

  # ============================================================================
  # Keyframes for View Transitions
  # ============================================================================

  # Animations for view transition pseudo-elements
  keyframes(:slide_in_from_right,
    from: [opacity: "0", transform: "translateX(30px)"],
    to: [opacity: "1", transform: "translateX(0)"]
  )

  keyframes(:slide_out_to_left,
    from: [opacity: "1", transform: "translateX(0)"],
    to: [opacity: "0", transform: "translateX(-30px)"]
  )

  keyframes(:scale_in,
    from: [opacity: "0", transform: "scale(0.8)"],
    to: [opacity: "1", transform: "scale(1)"]
  )

  keyframes(:scale_out,
    from: [opacity: "1", transform: "scale(1)"],
    to: [opacity: "0", transform: "scale(0.8)"]
  )

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
  # Page Layout
  # ============================================================================

  style(:page,
    min_height: "100vh",
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
    font_family: var(:font_sans)
  )

  style(:back_link,
    display: "inline-flex",
    align_items: "center",
    gap: var(:space_2),
    color: "rgba(255, 255, 255, 0.8)",
    font_size: var(:text_size_sm),
    font_weight: var(:font_weight_medium),
    text_decoration: "none",
    padding: var(:space_4),
    transition: "color 0.2s ease",
    ":hover": [color: var(:color_white)]
  )

  style(:content,
    padding_top: var(:space_8),
    padding_bottom: var(:space_16)
  )

  style(:container,
    __include__: [{BaseStyles, :container_narrow}],
    max_width: "32rem"
  )

  # ============================================================================
  # Card
  # ============================================================================

  style(:card,
    background_color: var(:color_white),
    border_radius: var(:radius_2xl),
    box_shadow: "0 25px 50px -12px rgba(0, 0, 0, 0.25)",
    overflow: "hidden"
  )

  style(:card_header,
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
    padding: var(:space_6),
    color: var(:color_white)
  )

  style(:card_title,
    font_size: var(:text_size_2xl),
    font_weight: var(:font_weight_bold),
    margin: "0",
    display: "flex",
    align_items: "center",
    gap: var(:space_3)
  )

  style(:card_subtitle,
    font_size: var(:text_size_sm),
    opacity: "0.9",
    margin_top: var(:space_1)
  )

  style(:card_body,
    padding: var(:space_6)
  )

  # ============================================================================
  # Input Form
  # ============================================================================

  style(:form,
    display: "flex",
    gap: var(:space_3),
    margin_bottom: var(:space_6)
  )

  style(:input,
    flex: "1",
    padding: var(:space_3),
    font_size: var(:text_size_base),
    border_width: "2px",
    border_style: "solid",
    border_color: var(:color_gray_200),
    border_radius: var(:radius_lg),
    outline: "none",
    transition: "border-color 0.2s ease, box-shadow 0.2s ease",
    ":focus": [
      border_color: var(:color_indigo_500),
      box_shadow: "0 0 0 3px rgba(99, 102, 241, 0.1)"
    ]
  )

  style(:add_button,
    __include__: [{BaseStyles, :btn_base}],
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
    color: var(:color_white),
    padding_left: var(:space_5),
    padding_right: var(:space_5),
    font_weight: var(:font_weight_semibold),
    box_shadow: "0 4px 14px 0 rgba(102, 126, 234, 0.4)",
    ":hover": [
      transform: "translateY(-1px)",
      box_shadow: "0 6px 20px 0 rgba(102, 126, 234, 0.5)"
    ],
    ":active": [transform: "translateY(0)"]
  )

  # ============================================================================
  # Todo List
  # ============================================================================

  style(:todo_list,
    list_style: "none",
    padding: "0",
    margin: "0"
  )

  style(:todo_item,
    display: "flex",
    align_items: "center",
    gap: var(:space_3),
    padding: var(:space_4),
    border_radius: var(:radius_lg),
    margin_bottom: var(:space_2),
    background_color: var(:color_gray_50),
    transition: "background-color 0.2s ease",
    # Each todo item gets a unique view-transition-name via inline style
    contain: "layout",
    ":hover": [background_color: var(:color_gray_100)]
  )

  style(:todo_item_completed,
    opacity: "0.6",
    background_color: var(:color_green_50),
    ":hover": [background_color: var(:color_green_100)]
  )

  # ============================================================================
  # Checkbox
  # ============================================================================

  style(:checkbox_wrapper,
    position: "relative",
    width: "1.5rem",
    height: "1.5rem",
    flex_shrink: "0"
  )

  style(:checkbox_input,
    position: "absolute",
    opacity: "0",
    width: "100%",
    height: "100%",
    cursor: "pointer",
    z_index: "1"
  )

  style(:checkbox_custom,
    position: "absolute",
    top: "0",
    left: "0",
    width: "100%",
    height: "100%",
    border_width: "2px",
    border_style: "solid",
    border_color: var(:color_gray_300),
    border_radius: var(:radius_md),
    background_color: var(:color_white),
    transition: "all 0.2s ease",
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  style(:checkbox_custom_checked,
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
    border_color: "transparent",
    animation_name: :check_bounce,
    animation_duration: "0.3s",
    animation_timing_function: "ease-out"
  )

  style(:checkbox_icon,
    color: var(:color_white),
    font_size: "0.75rem",
    opacity: "0",
    transform: "scale(0)",
    transition: "all 0.2s ease"
  )

  style(:checkbox_icon_visible,
    opacity: "1",
    transform: "scale(1)"
  )

  # ============================================================================
  # Todo Text
  # ============================================================================

  style(:todo_text_wrapper,
    flex: "1",
    position: "relative",
    overflow: "hidden"
  )

  style(:todo_text,
    font_size: var(:text_size_base),
    color: var(:color_gray_700),
    transition: "color 0.2s ease"
  )

  style(:todo_text_completed,
    color: var(:color_gray_400)
  )

  style(:todo_strike,
    position: "absolute",
    top: "50%",
    left: "0",
    height: "2px",
    background_color: var(:color_gray_400),
    animation_name: :strike_through,
    animation_duration: "0.3s",
    animation_timing_function: "ease-out",
    animation_fill_mode: "forwards"
  )

  # ============================================================================
  # Delete Button
  # ============================================================================

  style(:delete_button,
    __include__: [{BaseStyles, :interactive}],
    width: "2rem",
    height: "2rem",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    border_radius: var(:radius_full),
    color: var(:color_gray_400),
    background_color: "transparent",
    border: "none",
    font_size: var(:text_size_lg),
    opacity: "0",
    transform: "scale(0.8)",
    transition: "all 0.2s ease",
    ":hover": [
      color: var(:color_red_500),
      background_color: var(:color_red_50)
    ]
  )

  style(:delete_button_visible,
    opacity: "1",
    transform: "scale(1)"
  )

  # ============================================================================
  # Empty State
  # ============================================================================

  style(:empty_state,
    text_align: "center",
    padding: var(:space_8),
    color: var(:color_gray_400)
  )

  style(:empty_icon,
    font_size: "3rem",
    margin_bottom: var(:space_4),
    opacity: "0.5"
  )

  style(:empty_text,
    font_size: var(:text_size_lg),
    margin_bottom: var(:space_2)
  )

  style(:empty_subtext,
    font_size: var(:text_size_sm)
  )

  # ============================================================================
  # Filter Buttons
  # ============================================================================

  style(:filter_group,
    display: "flex",
    justify_content: "center",
    gap: var(:space_2),
    margin_bottom: var(:space_4)
  )

  style(:filter_button,
    __include__: [{BaseStyles, :interactive}],
    padding_top: var(:space_2),
    padding_bottom: var(:space_2),
    padding_left: var(:space_4),
    padding_right: var(:space_4),
    font_size: var(:text_size_sm),
    color: var(:color_gray_500),
    background_color: "transparent",
    border_width: "1px",
    border_style: "solid",
    border_color: var(:color_gray_200),
    border_radius: var(:radius_full),
    transition: "all 0.2s ease",
    ":hover": [
      border_color: var(:color_gray_300),
      color: var(:color_gray_700)
    ]
  )

  style(:filter_button_active,
    background: "linear-gradient(135deg, #667eea 0%, #764ba2 100%)",
    color: var(:color_white),
    border_color: "transparent",
    ":hover": [color: var(:color_white)]
  )

  # ============================================================================
  # Input Shake Animation
  # ============================================================================

  style(:input_shake,
    animation_name: :shake,
    animation_duration: "0.4s",
    animation_timing_function: "ease-out",
    border_color: var(:color_red_400),
    ":focus": [
      border_color: var(:color_red_400),
      box_shadow: "0 0 0 3px rgba(248, 113, 113, 0.2)"
    ]
  )

  # ============================================================================
  # Footer Stats
  # ============================================================================

  style(:footer,
    display: "flex",
    justify_content: "space-between",
    align_items: "center",
    padding_top: var(:space_4),
    border_top_width: "1px",
    border_top_style: "solid",
    border_top_color: var(:color_gray_200),
    margin_top: var(:space_4)
  )

  style(:stats,
    font_size: var(:text_size_sm),
    color: var(:color_gray_500)
  )

  style(:clear_button,
    __include__: [{BaseStyles, :interactive}],
    font_size: var(:text_size_sm),
    color: var(:color_gray_500),
    background: "none",
    border: "none",
    text_decoration: [
      default: "none",
      ":hover": "underline"
    ]
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
     assign(socket,
       page_title: "Todo Demo",
       todos: todos,
       new_todo: "",
       next_id: 5,
       hover_id: nil,
       filter: :all,
       input_error: false
     )}
  end

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
    filter = String.to_existing_atom(filter)
    {:noreply, assign(socket, filter: filter)}
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

  @impl true
  def handle_event("hover_item", %{"id" => id}, socket) do
    {:noreply, assign(socket, hover_id: String.to_integer(id))}
  end

  @impl true
  def handle_event("unhover_item", _params, socket) do
    {:noreply, assign(socket, hover_id: nil)}
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
    <div class={style([:page])} id="todo-page">
      <.link navigate="/" class={style([:back_link])}>
        &#8592; Back to Home
      </.link>
      <div class={style([:content])}>
        <div class={style([:container])}>
          <div class={style([:card])}>
            <%!-- Header --%>
            <div class={style([:card_header])}>
              <h1 class={style([:card_title])}>
                <span>&#9745;</span> Todo List
              </h1>
              <p class={style([:card_subtitle])}>
                Built with LiveStyle &amp; View Transitions API
              </p>
            </div>

            <div class={style([:card_body])}>
              <%!-- Input Form --%>
              <form phx-submit="add_todo" class={style([:form])}>
                <input
                  type="text"
                  name="text"
                  value={@new_todo}
                  placeholder="What needs to be done?"
                  phx-change="update_input"
                  phx-hook=".ShakeInput"
                  id="todo-input"
                  class={input_class(@input_error)}
                  autocomplete="off"
                />
                <button type="submit" class={style([:add_button])}>
                  Add
                </button>
              </form>

              <%!-- Filter Buttons --%>
              <%= if not Enum.empty?(@todos) do %>
                <div class={style([:filter_group])}>
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
                <div class={style([:empty_state])}>
                  <div class={style([:empty_icon])}>&#128203;</div>
                  <p class={style([:empty_text])}>No todos yet!</p>
                  <p class={style([:empty_subtext])}>Add one above to get started</p>
                </div>
              <% else %>
                <ul class={style([:todo_list])}>
                  <%= for todo <- filtered_todos(@todos, @filter) do %>
                    <li
                      id={"todo-#{todo.id}"}
                      class={todo_item_class(todo)}
                      style={"view-transition-name: todo-#{todo.id}"}
                      phx-mouseenter="hover_item"
                      phx-mouseleave="unhover_item"
                      phx-value-id={todo.id}
                    >
                      <%!-- Checkbox --%>
                      <div class={style([:checkbox_wrapper])}>
                        <input
                          type="checkbox"
                          checked={todo.completed}
                          phx-click="toggle_todo"
                          phx-value-id={todo.id}
                          class={style([:checkbox_input])}
                        />
                        <div class={checkbox_class(todo.completed)}>
                          <span class={checkbox_icon_class(todo.completed)}>&#10003;</span>
                        </div>
                      </div>

                      <%!-- Text --%>
                      <div class={style([:todo_text_wrapper])}>
                        <span class={todo_text_class(todo.completed)}>
                          {todo.text}
                        </span>
                        <%= if todo.completed do %>
                          <div class={style([:todo_strike])}></div>
                        <% end %>
                      </div>

                      <%!-- Delete Button --%>
                      <button
                        type="button"
                        phx-click="delete_todo"
                        phx-value-id={todo.id}
                        class={delete_button_class(@hover_id == todo.id)}
                        aria-label="Delete todo"
                      >
                        &#10005;
                      </button>
                    </li>
                  <% end %>
                </ul>

                <%!-- Footer --%>
                <div class={style([:footer])}>
                  <span class={style([:stats])}>
                    {items_left(@todos)} item{if items_left(@todos) != 1, do: "s"} left
                  </span>
                  <%= if completed_count(@todos) > 0 do %>
                    <button
                      type="button"
                      phx-click="clear_completed"
                      class={style([:clear_button])}
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
    """
  end

  # Class composition helpers
  defp todo_item_class(todo) do
    base = [:todo_item]
    base = if todo.completed, do: base ++ [:todo_item_completed], else: base
    style(base)
  end

  defp checkbox_class(completed) do
    if completed do
      style([:checkbox_custom, :checkbox_custom_checked])
    else
      style([:checkbox_custom])
    end
  end

  defp checkbox_icon_class(completed) do
    if completed do
      style([:checkbox_icon, :checkbox_icon_visible])
    else
      style([:checkbox_icon])
    end
  end

  defp todo_text_class(completed) do
    if completed do
      style([:todo_text, :todo_text_completed])
    else
      style([:todo_text])
    end
  end

  defp delete_button_class(visible) do
    if visible do
      style([:delete_button, :delete_button_visible])
    else
      style([:delete_button])
    end
  end

  defp input_class(error) do
    if error do
      style([:input, :input_shake])
    else
      style([:input])
    end
  end

  defp filter_button_class(active) do
    if active do
      style([:filter_button, :filter_button_active])
    else
      style([:filter_button])
    end
  end
end
