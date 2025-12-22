defmodule LiveStyleDemoWeb.HasLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  css_class(:demo_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fill, minmax(280px, 1fr))",
    gap: css_var({Tokens, :space, :"6"})
  )

  # ============================================================================
  # Demo 1: Card with Optional Image (:has(img))
  # ============================================================================

  # StyleX pattern: use conditional values on each property
  css_class(:card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    overflow: "hidden",
    transition: "box-shadow 0.2s ease",
    # Cards with images get a shadow - using :has() as a condition
    box_shadow: %{
      :default => "none",
      ":has(img)" => css_const({Tokens, :shadow, :lg})
    }
  )

  css_class(:card_image,
    width: "100%",
    height: "160px",
    object_fit: "cover"
  )

  css_class(:card_body,
    padding: css_var({Tokens, :space, :"4"})
  )

  css_class(:card_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_class(:card_text,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  # ============================================================================
  # Demo 2: Form Validation - using separate classes for states
  # ============================================================================

  css_class(:form,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"6"}),
    max_width: "400px"
  )

  css_class(:form_group,
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:label,
    display: "block",
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"1"}),
    transition: "color 0.2s ease"
  )

  css_class(:input,
    width: "100%",
    padding_block: css_var({Tokens, :space, :"2.5"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :base}),
    transition: "border-color 0.2s ease, background-color 0.2s ease",
    outline: %{
      :default => nil,
      ":focus" => "none"
    },
    # Note: :user-invalid and :user-valid are newer pseudo-classes
    # that only apply after user interaction
    background_color: %{
      :default => css_var({Tokens, :semantic, :fill_page}),
      ":focus" => css_var({Tokens, :semantic, :fill_page}),
      ":invalid:not(:placeholder-shown)" =>
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 12%, #{css_var({Tokens, :semantic, :fill_page})})",
      ":valid:not(:placeholder-shown)" =>
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_success})} 12%, #{css_var({Tokens, :semantic, :fill_page})})"
    },
    border_color: %{
      :default => css_var({Tokens, :semantic, :border_subtle}),
      ":focus" => css_var({Tokens, :semantic, :border_focus}),
      ":invalid:not(:placeholder-shown)" => css_var({Tokens, :semantic, :border_danger}),
      ":valid:not(:placeholder-shown)" => css_var({Tokens, :semantic, :border_success})
    }
  )

  css_class(:error_message,
    font_size: css_const({Tokens, :font_size, :xs}),
    color: css_var({Tokens, :semantic, :text_danger}),
    margin_top: css_var({Tokens, :space, :"1"}),
    # Hidden by default, shown via JavaScript or :has() on parent
    display: "none"
  )

  # ============================================================================
  # Demo 3: Interactive List (:has(:checked))
  # ============================================================================

  css_class(:task_list,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    border_radius: css_const({Tokens, :radius, :lg}),
    overflow: "hidden",
    max_width: "400px"
  )

  css_class(:task_item,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"}),
    border_bottom: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_subtle}),
    transition: "background-color 0.2s ease",
    cursor: "pointer",
    # Style the item when its checkbox is checked using :has()
    background_color: %{
      :default => "transparent",
      ":has(input:checked)" =>
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_success})} 12%, #{css_var({Tokens, :semantic, :fill_page})})"
    }
  )

  css_class(:task_item_last,
    border_bottom: "none"
  )

  css_class(:task_checkbox,
    width: "20px",
    height: "20px",
    accent_color: css_var({Tokens, :semantic, :fill_success}),
    cursor: "pointer"
  )

  css_class(:task_text,
    flex: "1",
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_primary}),
    transition: "color 0.2s ease, text-decoration 0.2s ease"
  )

  # Separate class for checked state text styling
  css_class(:task_text_checked,
    text_decoration: "line-through",
    color: css_var({Tokens, :semantic, :text_muted})
  )

  # ============================================================================
  # Demo 4: Focus Within
  # ============================================================================

  css_class(:search_wrapper,
    max_width: "400px"
  )

  css_class(:search_box,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"2.5"}),
    padding_inline: css_var({Tokens, :space, :"3.5"}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border: "2px solid",
    border_radius: css_const({Tokens, :radius, :lg}),
    transition: "border-color 0.2s ease, box-shadow 0.2s ease",
    # Use :has(input:focus) to style container when input is focused
    border_color: %{
      :default => css_var({Tokens, :semantic, :border_subtle}),
      ":has(input:focus)" => css_var({Tokens, :semantic, :border_focus})
    },
    box_shadow: %{
      :default => "none",
      ":has(input:focus)" => "0 0 0 3px #{css_var({Tokens, :semantic, :focus_ring})}"
    }
  )

  css_class(:search_icon,
    width: "20px",
    height: "20px",
    transition: "color 0.2s ease",
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:search_input,
    flex: "1",
    border: "none",
    background: "transparent",
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_primary}),
    outline: %{
      :default => nil,
      ":focus" => "none"
    }
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
      active="has"
      page_title=":has()"
      page_subtitle="The parent selector: conditional styling from descendants."
    >
      <section class={css_class([{BaseStyles, :demo_section}])}>
        <h2 class={css_class([{BaseStyles, :demo_section_title}])}>Cards with Optional Images</h2>
        <p class={css_class([{BaseStyles, :demo_section_description}])}>
          Cards that contain images get a shadow using
          <code class={css_class([{BaseStyles, :demo_code_inline}])}>:has(img)</code>
          as a condition.
          The "parent selector" finally exists in CSS!
        </p>

        <div class={css_class([:demo_grid])}>
          <div class={css_class([:card])}>
            <img
              src="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop"
              alt="Mountains"
              class={css_class([:card_image])}
            />
            <div class={css_class([:card_body])}>
              <h3 class={css_class([:card_title])}>Card with Image</h3>
              <p class={css_class([:card_text])}>This card has an image, so it gets a shadow.</p>
            </div>
          </div>

          <div class={css_class([:card])}>
            <div class={css_class([:card_body])}>
              <h3 class={css_class([:card_title])}>Card without Image</h3>
              <p class={css_class([:card_text])}>
                This card has no image, so no shadow is applied.
              </p>
            </div>
          </div>

          <div class={css_class([:card])}>
            <img
              src="https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400&h=200&fit=crop"
              alt="Nature"
              class={css_class([:card_image])}
            />
            <div class={css_class([:card_body])}>
              <h3 class={css_class([:card_title])}>Another Image Card</h3>
              <p class={css_class([:card_text])}>
                Images trigger the shadow styling automatically.
              </p>
            </div>
          </div>
        </div>
      </section>

      <section class={css_class([{BaseStyles, :demo_section}])}>
        <h2 class={css_class([{BaseStyles, :demo_section_title}])}>Form Validation</h2>
        <p class={css_class([{BaseStyles, :demo_section_description}])}>
          Input fields change color based on validation state using
          <code class={css_class([{BaseStyles, :demo_code_inline}])}>
            :invalid:not(:placeholder-shown)
          </code>
          and <code class={css_class([{BaseStyles, :demo_code_inline}])}>:valid:not(:placeholder-shown)</code>.
        </p>

        <form class={css_class([:form])} onsubmit="return false;">
          <div class={css_class([:form_group])}>
            <label class={css_class([:label])}>Email</label>
            <input type="email" class={css_class([:input])} placeholder="you@example.com" required />
          </div>

          <div class={css_class([:form_group])}>
            <label class={css_class([:label])}>Password (min 8 chars)</label>
            <input
              type="password"
              class={css_class([:input])}
              placeholder="••••••••"
              minlength="8"
              required
            />
          </div>
        </form>
      </section>

      <section class={css_class([{BaseStyles, :demo_section}])}>
        <h2 class={css_class([{BaseStyles, :demo_section_title}])}>Interactive Checklist</h2>
        <p class={css_class([{BaseStyles, :demo_section_description}])}>
          Task items style themselves when checked using <code class={
            css_class([{BaseStyles, :demo_code_inline}])
          }>:has(input:checked)</code>.
          Click the checkboxes to see the effect!
        </p>

        <div class={css_class([:task_list])}>
          <%= for {task, index} <- Enum.with_index(@tasks) do %>
            <label class={css_class([:task_item]) <> if(index == length(@tasks) - 1, do: " " <> css_class([:task_item_last]), else: "")}>
              <input
                type="checkbox"
                class={css_class([:task_checkbox])}
                checked={task.checked}
                phx-click="toggle_task"
                phx-value-id={task.id}
              />
              <span class={css_class([:task_text]) <> if(task.checked, do: " " <> css_class([:task_text_checked]), else: "")}>
                {task.text}
              </span>
            </label>
          <% end %>
        </div>
      </section>

      <section class={css_class([{BaseStyles, :demo_section}])}>
        <h2 class={css_class([{BaseStyles, :demo_section_title}])}>Focus Within</h2>
        <p class={css_class([{BaseStyles, :demo_section_description}])}>
          The search wrapper highlights when its input has focus using <code class={
            css_class([{BaseStyles, :demo_code_inline}])
          }>:has(input:focus)</code>.
        </p>

        <div class={css_class([:search_wrapper])}>
          <div class={css_class([:search_box])}>
            <svg
              class={css_class([:search_icon])}
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
            <input type="text" class={css_class([:search_input])} placeholder="Search..." />
          </div>
        </div>
      </section>
    </.shell>
    """
  end
end
