defmodule LiveStyleDemoWeb.ThemingLive do
  use LiveStyleDemoWeb, :live_view

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:intro,
    display: "grid",
    gap: var({Space, :"3"}),
    margin_bottom: var({Space, :"12"})
  )

  class(:intro_text,
    max_width: "80ch",
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:controls,
    display: "flex",
    flex_wrap: "wrap",
    gap: var({Space, :"2"}),
    align_items: "center"
  )

  class(:panel,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  class(:panel_header,
    padding: var({Space, :"6"}),
    border_bottom: "1px solid #{var({Semantic, :border_glass})}",
    display: "grid",
    gap: var({Space, :"2"})
  )

  class(:panel_title,
    font_size: const({Tokens, :font_size_xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    line_height: const({Tokens, :leading_tight})
  )

  class(:panel_subtitle,
    max_width: "80ch",
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:tag,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    padding_block: var({Space, :"1"}),
    padding_inline: var({Space, :"2.5"}),
    border_radius: const({Tokens, :radius_full}),
    font_size: const({Tokens, :font_size_sm}),
    font_weight: const({Tokens, :font_weight_medium}),
    background_color: var({Semantic, :fill_muted}),
    border: "1px solid #{var({Semantic, :border_default})}",
    color: var({Semantic, :text_secondary}),
    justify_self: "start"
  )

  class(:panel_body,
    padding: var({Space, :"6"}),
    display: "grid",
    gap: var({Space, :"6"})
  )

  class(:preview_card,
    background_color: var({Semantic, :fill_page}),
    border_radius: const({Tokens, :radius_xl}),
    border: "1px solid #{var({Semantic, :border_subtle})}",
    padding: var({Space, :"6"}),
    display: "grid",
    gap: var({Space, :"4"})
  )

  class(:preview_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    line_height: const({Tokens, :leading_tight})
  )

  class(:preview_text,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:preview_row,
    display: "flex",
    flex_wrap: "wrap",
    gap: var({Space, :"3"})
  )

  class(:code_grid,
    display: "grid",
    grid_template_columns: "repeat(auto-fit, minmax(min(420px, 100%), 1fr))",
    gap: var({Space, :"4"})
  )

  class(:code_block,
    background_color: var({Semantic, :fill_surface}),
    border: "1px solid #{var({Semantic, :border_subtle})}",
    border_radius: const({Tokens, :radius_xl}),
    padding: var({Space, :"4"}),
    overflow_x: "auto",
    display: "grid",
    gap: var({Space, :"2"}),
    min_width: "0"
  )

  class(:code_title,
    font_size: const({Tokens, :font_size_sm}),
    font_weight: const({Tokens, :font_weight_semibold}),
    color: var({Semantic, :text_primary})
  )

  class(:code_pre,
    margin: "0",
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_sm}),
    line_height: const({Tokens, :leading_relaxed}),
    color: var({Semantic, :text_secondary}),
    white_space: "pre"
  )

  class(:diff_line,
    display: "block",
    white_space: "pre"
  )

  class(:diff_added,
    color:
      "color-mix(in oklab, #{var({Semantic, :fill_success})} 85%, #{var({Semantic, :text_secondary})})"
  )

  class(:diff_removed,
    color:
      "color-mix(in oklab, #{var({Semantic, :fill_danger})} 80%, #{var({Semantic, :text_secondary})})"
  )

  class(:diff_context,
    color: var({Semantic, :text_secondary})
  )

  class(:toggle_btn_active,
    background_color: [
      default: var({Semantic, :fill_primary}),
      ":hover": var({Semantic, :fill_primary_hover})
    ],
    color: [
      default: var({Semantic, :text_on_primary}),
      ":hover": var({Semantic, :text_on_primary})
    ],
    border_color: "transparent"
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Theming", scale: :default)}
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
  defp scale_class(:compact), do: theme_class({Space, :compact})
  defp scale_class(:cozy), do: theme_class({Space, :cozy})

  defp toggle_active_class(true), do: css(:toggle_btn_active).class
  defp toggle_active_class(false), do: nil

  defp scale_label(:default), do: "Default"
  defp scale_label(:compact), do: "Compact"
  defp scale_label(:cozy), do: "Cozy"

  defp diff_lines(:default) do
    [
      {:context, "# Using the default spacing variables"},
      {:context, "vars ... "},
      {:context, ""},
      {:context, "# Try Compact or Cozy to see an override"}
    ]
  end

  defp diff_lines(scale) when scale in [:compact, :cozy] do
    title = "theme(:space, :#{scale}, ...)"

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
    <div {css(:preview_card)}>
      <h3 {css(:preview_title)}>Ship UI faster</h3>
      <p {css(:preview_text)}>Spacing comes from tokens.</p>
      <div {css(:preview_row)}>
        <.button variant={:primary}>Primary</.button>
        <.button variant={:secondary}>Secondary</.button>
      </div>
    </div>
    """
  end

  defp diff_class(:added), do: :diff_added
  defp diff_class(:removed), do: :diff_removed
  defp diff_class(:context), do: :diff_context

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="theming"
      show_footer
      page_title="Theming"
      page_subtitle="Change spacing scales with tokens—not template refactors."
    >
      <div {css(:intro)}>
        <p {css(:intro_text)}>
          In a utility-class world, changing your spacing scale often means touching a lot of markup.
          LiveStyle keeps spacing decisions in tokens, so global design changes are centralized.
        </p>

        <div {css(:controls)}>
          <span {css(:tag)}>Spacing scale</span>
          <.button
            type="button"
            size={:sm}
            variant={:secondary}
            phx-click="set_scale"
            phx-value-scale="compact"
            class={toggle_active_class(@scale == :compact)}
          >
            Compact
          </.button>
          <.button
            type="button"
            size={:sm}
            variant={:secondary}
            phx-click="set_scale"
            phx-value-scale="default"
            class={toggle_active_class(@scale == :default)}
          >
            Default
          </.button>
          <.button
            type="button"
            size={:sm}
            variant={:secondary}
            phx-click="set_scale"
            phx-value-scale="cozy"
            class={toggle_active_class(@scale == :cozy)}
          >
            Cozy
          </.button>
        </div>
      </div>

      <section {css([:panel, scale_class(@scale)])}>
        <header {css(:panel_header)}>
          <span {css(:tag)}>{scale_label(@scale)} spacing</span>
          <h2 {css(:panel_title)}>Same markup. Different spacing.</h2>
          <p {css(:panel_subtitle)}>
            This simulates the "designer changes the spacing scale six months later" moment.
            With tokens, it's a centralized change—not a template refactor.
          </p>
        </header>

        <div {css(:panel_body)}>
          <div {css(:preview_card)}>
            <h3 {css(:preview_title)}>Ship UI faster</h3>
            <p {css(:preview_text)}>
              Every gap and padding is driven by the "space" token group.
              Switch the scale and the layout reflows.
            </p>
            <div {css(:preview_row)}>
              <.button variant={:primary}>Primary</.button>
              <.button variant={:secondary}>Secondary</.button>
            </div>
          </div>

          <div {css(:code_grid)}>
            <div {css(:code_block)}>
              <p {css(:code_title)}>Token override (diff-ish)</p>
              <pre {css(:code_pre)}>
    <%= for {type, line} <- diff_lines(@scale) do %><span {css([:diff_line, diff_class(type)])}><%= line %></span>
    <% end %></pre>
            </div>

            <div {css(:code_block)}>
              <p {css(:code_title)}>Markup (unchanged)</p>
              <pre {css(:code_pre)}>{markup_code()}</pre>
            </div>
          </div>
        </div>
      </section>
    </.shell>
    """
  end
end
