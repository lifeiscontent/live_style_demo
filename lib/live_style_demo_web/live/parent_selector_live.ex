defmodule LiveStyleDemoWeb.ParentSelectorLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:demo_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fill, minmax(280px, 1fr))",
    gap: var({Space, :"6"})
  )

  # ============================================================================
  # Demo 1: Card with Optional Image (:has(img))
  # ============================================================================

  # StyleX pattern: use conditional values on each property
  class(:card,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    overflow: "hidden",
    transition: "box-shadow 0.2s ease, transform 0.2s ease",
    # Cards with images get a stronger shadow
    box_shadow: %{
      :default => "none",
      ":has(img)" =>
        "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}"
    }
  )

  class(:card_image,
    width: "100%",
    height: "160px",
    object_fit: "cover"
  )

  class(:card_body,
    padding: var({Space, :"6"})
  )

  class(:card_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_bold}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"2"})
  )

  class(:card_text,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  # ============================================================================
  # Demo 2: Form Validation - using separate classes for states
  # ============================================================================

  class(:form,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    padding: var({Space, :"8"}),
    max_width: "400px"
  )

  class(:form_group,
    margin_bottom: var({Space, :"4"})
  )

  class(:label,
    display: "block",
    font_size: const({Tokens, :font_size_sm}),
    font_weight: const({Tokens, :font_weight_medium}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"1"}),
    transition: "color 0.2s ease"
  )

  class(:input,
    width: "100%",
    padding_block: var({Space, :"2.5"}),
    padding_inline: var({Space, :"3"}),
    # Split shorthand to avoid overriding border-color
    border_width: "1px",
    border_style: "solid",
    border_radius: const({Tokens, :radius_md}),
    font_size: const({Tokens, :font_size_base}),
    transition: "border-color 0.2s ease, background-color 0.2s ease",
    outline: %{
      :default => nil,
      ":focus" => "none"
    },
    background_color: var({Semantic, :fill_page}),
    color: %{
      :default => var({Semantic, :text_primary}),
      ":invalid:not(:placeholder-shown)" => var({Semantic, :text_danger}),
      ":valid:not(:placeholder-shown)" => var({Semantic, :text_success})
    },
    border_color: %{
      :default => var({Semantic, :border_subtle}),
      ":focus" => var({Semantic, :border_focus}),
      ":invalid:not(:placeholder-shown)" => var({Semantic, :fill_danger}),
      ":valid:not(:placeholder-shown)" => var({Semantic, :fill_success})
    }
  )

  class(:error_message,
    font_size: const({Tokens, :font_size_xs}),
    color: var({Semantic, :text_danger}),
    margin_top: var({Space, :"1"}),
    # Hidden by default, shown via JavaScript or :has() on parent
    display: "none"
  )

  # ============================================================================
  # Demo 3: Interactive List (:has(:checked))
  # ============================================================================

  class(:task_list,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    overflow: "hidden",
    max_width: "400px"
  )

  class(:task_item,
    display: "flex",
    align_items: "center",
    gap: var({Space, :"3"}),
    padding: var({Space, :"4"}),
    border_bottom: "1px solid",
    border_color: var({Semantic, :border_subtle}),
    transition: "background-color 0.2s ease",
    cursor: "pointer",
    # Style the item when its checkbox is checked using :has()
    background_color: %{
      :default => var({Semantic, :fill_page}),
      ":invalid:not(:placeholder-shown)" => var({Semantic, :fill_danger}),
      ":valid:not(:placeholder-shown)" => var({Semantic, :fill_success})
    },
    box_shadow: %{
      :default => "none",
      ":has(input:focus)" => "0 0 0 3px #{var({Semantic, :focus_ring})}"
    }
  )

  class(:search_icon,
    width: "20px",
    height: "20px",
    transition: "color 0.2s ease",
    color: var({Semantic, :text_muted})
  )

  class(:search_wrapper,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    padding: var({Space, :"6"}),
    max_width: "420px"
  )

  class(:search_box,
    display: "flex",
    align_items: "center",
    gap: var({Space, :"3"}),
    padding: var({Space, :"3"}),
    background_color: var({Semantic, :fill_page}),
    border: "1px solid",
    border_color: var({Semantic, :border_subtle}),
    border_radius: const({Tokens, :radius_lg}),
    transition: "box-shadow 0.2s ease, border-color 0.2s ease",
    box_shadow: %{
      :default => "none",
      ":has(input:focus)" => "0 0 0 3px #{var({Semantic, :focus_ring})}"
    },
    border_color: %{
      :default => var({Semantic, :border_subtle}),
      ":has(input:focus)" => var({Semantic, :border_focus})
    }
  )

  class(:search_input,
    flex: "1",
    border: "none",
    background: "transparent",
    font_size: const({Tokens, :font_size_base}),
    color: var({Semantic, :text_primary}),
    outline: "none",
    min_width: "0"
  )

  # ============================================================================
  # LiveView Callbacks
  # ============================================================================

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: ":has() Selector", tasks: initial_tasks())}
  end

  defp initial_tasks do
    [
      %{id: 1, text: "Learn CSS :has() selector", checked: true},
      %{id: 2, text: "Build a demo", checked: false},
      %{id: 3, text: "Share with team", checked: false},
      %{id: 4, text: "Deploy to production", checked: false}
    ]
  end

  @impl true
  def handle_event("toggle_task", %{"id" => id}, socket) do
    id = String.to_integer(id)

    tasks =
      Enum.map(socket.assigns.tasks, fn task ->
        if task.id == id, do: %{task | checked: not task.checked}, else: task
      end)

    {:noreply, assign(socket, tasks: tasks)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="parent-selector"
      page_title=":has()"
      page_subtitle="The parent selector: conditional styling from descendants."
    >
      <.demo_section>
        <.demo_section_title>Cards with Optional Images</.demo_section_title>
        <.demo_section_description>
          Cards that contain images get a shadow using
          <.code_inline>:has(img)</.code_inline>
          as a condition.
          The "parent selector" finally exists in CSS!
        </.demo_section_description>

        <div {css(:demo_grid)}>
          <div {css(:card)}>
            <img
              src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop"
              alt="Mountains"
              {css(:card_image)}
            />
            <div {css(:card_body)}>
              <h3 {css(:card_title)}>Card with Image</h3>
              <p {css(:card_text)}>This card has an image, so it gets a shadow.</p>
            </div>
          </div>

          <div {css(:card)}>
            <div {css(:card_body)}>
              <h3 {css(:card_title)}>Card without Image</h3>
              <p {css(:card_text)}>
                This card has no image, so no shadow is applied.
              </p>
            </div>
          </div>

          <div {css(:card)}>
            <img
              src="https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400&h=200&fit=crop"
              alt="Nature"
              {css(:card_image)}
            />
            <div {css(:card_body)}>
              <h3 {css(:card_title)}>Another Image Card</h3>
              <p {css(:card_text)}>
                Images trigger the shadow styling automatically.
              </p>
            </div>
          </div>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Form Validation</.demo_section_title>
        <.demo_section_description>
          Input fields change color based on validation state using
          <.code_inline>:invalid:not(:placeholder-shown)</.code_inline>
          and <.code_inline>:valid:not(:placeholder-shown)</.code_inline>.
        </.demo_section_description>

        <form {css(:form)} onsubmit="return false;">
          <div {css(:form_group)}>
            <label {css(:label)}>Email</label>
            <input type="email" {css(:input)} placeholder="you@example.com" required />
          </div>

          <div {css(:form_group)}>
            <label {css(:label)}>Password (min 8 chars)</label>
            <input
              type="password"
              {css(:input)}
              placeholder="••••••••"
              minlength="8"
              required
            />
          </div>
        </form>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Interactive Checklist</.demo_section_title>
        <.demo_section_description>
          Task items style themselves when checked using <.code_inline>:has(input:checked)</.code_inline>.
          Click the checkboxes to see the effect!
        </.demo_section_description>

        <div {css(:task_list)}>
          <%= for {task, index} <- Enum.with_index(@tasks) do %>
            <label {css([:task_item, index == length(@tasks) - 1 && :task_item_last])}>
              <.input
                type="checkbox"
                checked={task.checked}
                phx-click="toggle_task"
                phx-value-id={task.id}
                aria-label="Toggle task"
              />
              <span {css([:task_text, task.checked && :task_text_checked])}>
                {task.text}
              </span>
            </label>
          <% end %>
        </div>
      </.demo_section>

      <.demo_section>
        <.demo_section_title>Focus Within</.demo_section_title>
        <.demo_section_description>
          The search wrapper highlights when its input has focus using <.code_inline>:has(input:focus)</.code_inline>.
        </.demo_section_description>

        <div {css(:search_wrapper)}>
          <div {css(:search_box)}>
            <svg
              {css(:search_icon)}
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
            <input type="text" {css(:search_input)} placeholder="Search..." />
          </div>
        </div>
      </.demo_section>
    </.shell>
    """
  end
end
