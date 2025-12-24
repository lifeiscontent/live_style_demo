defmodule LiveStyleDemoWeb.StyleGuideLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens

  css_class(:grid_section,
    display: "grid",
    gap: css_var({Tokens, :space, :"8"})
  )

  css_class(:component_row,
    display: "flex",
    flex_wrap: "wrap",
    align_items: "center",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:component_col,
    display: "flex",
    flex_direction: "column",
    gap: css_var({Tokens, :space, :"4"}),
    max_width: "24rem"
  )

  css_class(:section_label,
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_muted}),
    text_transform: "uppercase",
    letter_spacing: "0.05em",
    margin_bottom: css_var({Tokens, :space, :"4"}),
    display: "block"
  )

  css_class(:swatch,
    width: "100%",
    height: "4rem",
    border_radius: css_const({Tokens, :radius, :lg}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}"
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Style Guide", checkbox_1: true, checkbox_2: false)}
  end

  @impl true
  def handle_event("toggle_checkbox", %{"id" => id}, socket) do
    key = String.to_existing_atom(id)
    {:noreply, assign(socket, key, !socket.assigns[key])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="style-guide"
      page_title="Style Guide"
      page_subtitle="Reference for all base components."
    >
      <div class={css_class([:grid_section])}>
        <%!-- Typography --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Typography</span>
            <div class={css_class([:component_col])}>
              <.heading level={1} style={"font-size: #{css_const({Tokens, :font_size, :"4xl"})}"}>
                Heading 1
              </.heading>
              <.heading level={2} style={"font-size: #{css_const({Tokens, :font_size, :"3xl"})}"}>
                Heading 2
              </.heading>
              <.heading level={3} style={"font-size: #{css_const({Tokens, :font_size, :"2xl"})}"}>
                Heading 3
              </.heading>
              <.body_text>
                Body text. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                Nullam quis risus eget <.text_link href="#">urna mollis ornare</.text_link>
                vel eu leo.
              </.body_text>
              <.body_text size={:sm} muted>
                Small muted text.
              </.body_text>
            </div>
          </div>
        </.card>

        <%!-- Buttons --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Buttons</span>
            <div class={css_class([:component_row])}>
              <.button variant={:primary}>Primary</.button>
              <.button variant={:secondary}>Secondary</.button>
              <.button variant={:danger}>Danger</.button>
              <.button variant={:ghost}>Ghost</.button>
            </div>
            <div
              class={css_class([:component_row])}
              style={"margin-top: #{css_var({Tokens, :space, :"4"})}"}
            >
              <.button size={:sm} variant={:primary}>Small Primary</.button>
              <.button size={:sm} variant={:secondary}>Small Secondary</.button>
            </div>
          </div>
        </.card>

        <%!-- Forms --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Forms</span>
            <div class={css_class([:component_col])}>
              <.input placeholder="Bare input" value="Bare value" />
              <.input placeholder="Bare input (error)" value="Oops" error />

              <.field label="Standard Input" placeholder="Standard Input" />
              <.field label="Error State" value="Invalid input" error="Invalid input" />

              <div class={css_class([:component_row])}>
                <.field
                  type="checkbox"
                  label="Checkbox Option"
                  checked={@checkbox_1}
                  phx-click="toggle_checkbox"
                  phx-value-id="checkbox_1"
                />

                <.field
                  type="checkbox"
                  label="Another Option"
                  checked={@checkbox_2}
                  phx-click="toggle_checkbox"
                  phx-value-id="checkbox_2"
                />
              </div>
            </div>
          </div>
        </.card>

        <%!-- Links --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Links</span>
            <div class={css_class([:component_row])}>
              <.text_link href="#">Text Link</.text_link>
              <.button href="#" variant={:secondary}>Button Link</.button>
            </div>
          </div>
        </.card>

        <%!-- Icons --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Icons</span>
            <div class={css_class([:component_row])}>
              <.icon name="info" size={:md} />
              <.icon name="alert" size={:md} />
              <.icon name="check" size={:md} />
              <.icon name="close" size={:md} />
            </div>
          </div>
        </.card>

        <%!-- Flash --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Flash</span>
            <div class={css_class([:component_col])}>
              <.flash kind={:info} title="Info">
                Flash messages support icons + actions.
              </.flash>
              <.flash kind={:error} title="Error">
                Something went wrong.
              </.flash>
            </div>
          </div>
        </.card>

        <%!-- Overlays --%>
        <.card as={:section} overflow={:visible}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Overlays</span>

            <div class={css_class([:component_col])}>
              <.tooltip>Tooltip</.tooltip>

              <.toast variant={:success}>Saved!</.toast>

              <.modal title="Example Modal">
                <p>
                  This is the modal panel UI (no positioning/backdrop here).
                </p>

                <:actions>
                  <.button variant={:secondary}>
                    Close
                  </.button>
                </:actions>
              </.modal>

              <.menu>
                <.menu_item>Edit</.menu_item>
                <.menu_item>Duplicate</.menu_item>
                <.menu_divider />
                <.menu_item danger>Delete</.menu_item>
              </.menu>
            </div>
          </div>
        </.card>

        <%!-- Badges --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Badges</span>
            <div class={css_class([:component_row])}>
              <.badge variant={:neutral}>Neutral</.badge>
              <.badge variant={:primary}>Primary</.badge>
              <.badge variant={:outline}>Outline</.badge>
            </div>
          </div>
        </.card>

        <%!-- Skip Link --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Skip Link</span>
            <div class={css_class([:component_col])}>
              <.skip_link target="#main">Skip to content</.skip_link>
              <.body_text size={:sm} muted>
                The skip link is visually hidden until focused.
              </.body_text>
            </div>
          </div>
        </.card>

        <%!-- Colors --%>
        <.card as={:section}>
          <div style={"padding: #{css_var({Tokens, :space, :"8"})}"}>
            <span class={css_class([:section_label])}>Semantic Colors</span>
            <div class={css_class([:component_row])}>
              <div class={css_class([:component_col])} style="width: 100%">
                <div
                  class={css_class([:swatch])}
                  style={"background: #{css_var({Tokens, :semantic, :fill_primary})}"}
                  title="Primary"
                >
                </div>
                <div
                  class={css_class([:swatch])}
                  style={"background: #{css_var({Tokens, :semantic, :fill_secondary})}"}
                  title="Secondary"
                >
                </div>
                <div
                  class={css_class([:swatch])}
                  style={"background: #{css_var({Tokens, :semantic, :fill_surface})}"}
                  title="Surface"
                >
                </div>
                <div
                  class={css_class([:swatch])}
                  style={"background: #{css_var({Tokens, :semantic, :fill_danger})}"}
                  title="Danger"
                >
                </div>
              </div>
            </div>
          </div>
        </.card>
      </div>
    </.shell>
    """
  end
end
