defmodule LiveStyleDemoWeb.SixMonthTestLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.BaseStyles
  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  css_class(:intro,
    display: "grid",
    gap: css_var({Tokens, :space, :"3"}),
    margin_bottom: css_var({Tokens, :space, :"8"})
  )

  css_class(:intro_text,
    max_width: "80ch",
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:controls,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_var({Tokens, :space, :"2"}),
    align_items: "center"
  )

  css_class(:panel,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  css_class(:panel_header,
    padding: css_var({Tokens, :space, :"6"}),
    border_bottom: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    display: "grid",
    gap: css_var({Tokens, :space, :"2"})
  )

  css_class(:panel_title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:panel_subtitle,
    max_width: "80ch",
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:tag,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"1"}),
    padding_inline: css_var({Tokens, :space, :"2.5"}),
    border_radius: css_const({Tokens, :radius, :full}),
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_default})}",
    color: css_var({Tokens, :semantic, :text_secondary}),
    justify_self: "start"
  )

  css_class(:panel_body,
    padding: css_var({Tokens, :space, :"6"}),
    display: "grid",
    gap: css_var({Tokens, :space, :"6"})
  )

  css_class(:preview_card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    border_radius: css_const({Tokens, :radius, :xl}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_subtle})}",
    padding: css_var({Tokens, :space, :"6"}),
    display: "grid",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:preview_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:preview_text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:preview_row,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_var({Tokens, :space, :"3"})
  )

  css_class(:code_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fit, minmax(min(420px, 100%), 1fr))",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:code_block,
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_subtle})}",
    border_radius: css_const({Tokens, :radius, :xl}),
    padding: css_var({Tokens, :space, :"4"}),
    overflow_x: "auto",
    display: "grid",
    gap: css_var({Tokens, :space, :"2"}),
    min_width: "0"
  )

  css_class(:code_title,
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:code_pre,
    margin: "0",
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    white_space: "pre"
  )

  css_class(:diff_line,
    display: "block",
    white_space: "pre"
  )

  css_class(:diff_added,
    color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_success})} 85%, #{css_var({Tokens, :semantic, :text_secondary})})"
  )

  css_class(:diff_removed,
    color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 80%, #{css_var({Tokens, :semantic, :text_secondary})})"
  )

  css_class(:diff_context,
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  css_class(:toggle_btn_active,
    background_image: css_const({Tokens, :gradient, :accent}),
    color: css_var({Tokens, :semantic, :text_inverse}),
    border_color: "transparent"
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Six-Month Test", scale: :default)}
  end

  @impl true
  def handle_event("set_scale", %{"scale" => scale}, socket) do
    scale =
      case scale do
        "compact" -> :compact
        "cozy" -> :cozy
        _ -> :default
      end

    {:noreply, assign(socket, scale: scale)}
  end

  defp scale_class(:default), do: nil
  defp scale_class(:compact), do: css_theme({Tokens, :space, :compact})
  defp scale_class(:cozy), do: css_theme({Tokens, :space, :cozy})

  defp scale_label(:default), do: "Default"
  defp scale_label(:compact), do: "Compact"
  defp scale_label(:cozy), do: "Cozy"

  defp diff_lines(:default) do
    [
      {:context, "# Using the default spacing variables"},
      {:context, "css_vars(:space, ... )"},
      {:context, ""},
      {:context, "# Try Compact or Cozy to see an override"}
    ]
  end

  defp diff_lines(scale) when scale in [:compact, :cozy] do
    title = "css_theme(:space, :#{scale}, ...)"

    changes =
      case scale do
        :compact ->
          %{
            "4" => {"1rem", "0.8rem"},
            "6" => {"1.5rem", "1.2rem"},
            "8" => {"2rem", "1.6rem"},
            "12" => {"3rem", "2.4rem"}
          }

        :cozy ->
          %{
            "4" => {"1rem", "1.2rem"},
            "6" => {"1.5rem", "1.8rem"},
            "8" => {"2rem", "2.4rem"},
            "12" => {"3rem", "3.6rem"}
          }
      end

    [
      {:context, "# tokens.ex"},
      {:context, title},
      {:context, ""}
    ] ++
      Enum.flat_map(changes, fn {key, {from, to}} ->
        [
          {:removed, "-  \"#{key}\": \"#{from}\","},
          {:added, "+  \"#{key}\": \"#{to}\","}
        ]
      end)
  end

  defp markup_code do
    """
    # Same markup either way.
    <div class={css_class([:preview_card])}>
      <h3 class={css_class([:preview_title])}>Ship UI faster</h3>
      <p class={css_class([:preview_text])}>Spacing comes from tokens.</p>
      <div class={css_class([:preview_row])}>
        <button class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}>
          Primary
        </button>
        <button class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}>
          Secondary
        </button>
      </div>
    </div>
    """
  end

  defp diff_class(:added), do: :diff_added
  defp diff_class(:removed), do: :diff_removed
  defp diff_class(:context), do: :diff_context

  defp toggle_btn_class(active_scale, button_scale) do
    css_class([
      {BaseStyles, :btn_base},
      {BaseStyles, :btn_sm},
      {BaseStyles, :btn_secondary},
      active_scale == button_scale && :toggle_btn_active
    ])
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="six-month-test"
      show_footer
      page_title="The Six-Month Test"
      page_subtitle="Change spacing scales with tokens—not template refactors."
    >
      <div class={css_class([:intro])}>
        <p class={css_class([:intro_text])}>
          In a utility-class world, changing your spacing scale often means touching a lot of markup.
          LiveStyle keeps spacing decisions in tokens, so global design changes are centralized.
        </p>

        <div class={css_class([:controls])}>
          <span class={css_class([:tag])}>Spacing scale</span>
          <button
            type="button"
            phx-click="set_scale"
            phx-value-scale="compact"
            class={toggle_btn_class(@scale, :compact)}
          >
            Compact
          </button>
          <button
            type="button"
            phx-click="set_scale"
            phx-value-scale="default"
            class={toggle_btn_class(@scale, :default)}
          >
            Default
          </button>
          <button
            type="button"
            phx-click="set_scale"
            phx-value-scale="cozy"
            class={toggle_btn_class(@scale, :cozy)}
          >
            Cozy
          </button>
        </div>
      </div>

      <section class={[css_class([:panel]), scale_class(@scale)]}>
        <header class={css_class([:panel_header])}>
          <span class={css_class([:tag])}>{scale_label(@scale)} spacing</span>
          <h2 class={css_class([:panel_title])}>Same markup. Different spacing.</h2>
          <p class={css_class([:panel_subtitle])}>
            This simulates the “designer changes the spacing scale six months later” moment.
            With tokens, it’s a centralized change—not a template refactor.
          </p>
        </header>

        <div class={css_class([:panel_body])}>
          <div class={css_class([:preview_card])}>
            <h3 class={css_class([:preview_title])}>Ship UI faster</h3>
            <p class={css_class([:preview_text])}>
              Every gap and padding is driven by the "space" token group.
              Switch the scale and the layout reflows.
            </p>
            <div class={css_class([:preview_row])}>
              <button class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_primary}])}>
                Primary
              </button>
              <button class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}>
                Secondary
              </button>
            </div>
          </div>

          <div class={css_class([:code_grid])}>
            <div class={css_class([:code_block])}>
              <p class={css_class([:code_title])}>Token override (diff-ish)</p>
              <pre class={css_class([:code_pre])}>
    <%= for {type, line} <- diff_lines(@scale) do %><span class={css_class([:diff_line, diff_class(type)])}><%= line %></span>
    <% end %></pre>
            </div>

            <div class={css_class([:code_block])}>
              <p class={css_class([:code_title])}>Markup (unchanged)</p>
              <pre class={css_class([:code_pre])}>{markup_code()}</pre>
            </div>
          </div>
        </div>
      </section>
    </.shell>
    """
  end
end
