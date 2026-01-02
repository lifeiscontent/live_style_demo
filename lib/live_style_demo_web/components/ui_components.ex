defmodule LiveStyleDemoWeb.UIComponents do
  @moduledoc """
  Atomic UI components built with LiveStyle.
  """
  use Phoenix.Component
  use LiveStyle
  use Gettext, backend: LiveStyleDemoWeb.Gettext

  alias Phoenix.HTML.Form
  alias Phoenix.LiveView.JS

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  # ============================================================================
  # Flash Styles
  # ============================================================================

  class(:flash_container,
    display: "block"
  )

  class(:flash_alert,
    display: "flex",
    align_items: "flex-start",
    gap: var({Space, :"3"}),
    padding: var({Space, :"4"}),
    border_radius: const({Tokens, :radius_lg}),
    box_shadow: const({Tokens, :shadow_lg}),
    max_width: "24rem"
  )

  class(:flash_info,
    background_color: var({Semantic, :fill_surface}),
    border_width: "1px",
    border_style: "solid",
    border_color: var({Semantic, :border_default})
  )

  class(:flash_error,
    background_color:
      "color-mix(in oklab, #{var({Semantic, :fill_danger})} 10%, #{var({Semantic, :fill_surface})})",
    border_width: "1px",
    border_style: "solid",
    border_color:
      "color-mix(in oklab, #{var({Semantic, :fill_danger})} 30%, #{var({Semantic, :fill_surface})})"
  )

  class(:flash_content,
    flex: "1"
  )

  class(:flash_title,
    font_weight: const({Tokens, :font_weight_semibold}),
    margin_bottom: var({Space, :"1"})
  )

  class(:flash_close,
    background: "none",
    border: "none",
    cursor: "pointer",
    opacity: "0.5",
    transition: "opacity 0.2s ease"
  )

  # ============================================================================
  # Toast Styles
  # ============================================================================

  class(:toast_base,
    display: "flex",
    align_items: "center",
    gap: var({Space, :"3"}),
    padding: var({Space, :"4"}),
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    border_radius: const({Tokens, :radius_lg}),
    box_shadow: const({Tokens, :shadow_lg}),
    min_width: "min(280px, calc(100vw - #{var({Space, :"8"})}))",
    max_width: "min(360px, calc(100vw - #{var({Space, :"8"})}))"
  )

  class(:toast_success,
    background_color: var({Semantic, :fill_success})
  )

  class(:toast_danger,
    background_color: var({Semantic, :fill_danger})
  )

  class(:toast_icon,
    flex_shrink: "0"
  )

  class(:toast_message,
    flex: "1",
    font_size: const({Tokens, :font_size_sm})
  )

  class(:toast_close,
    padding: var({Space, :"1"}),
    background: "none",
    border: "none",
    cursor: "pointer",
    color: "inherit",
    opacity: [
      default: "0.7",
      ":hover": "1"
    ]
  )

  # ============================================================================
  # Menu Styles
  # ============================================================================

  class(:menu_panel,
    padding: var({Space, :"2"}),
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid",
    border_color: var({Semantic, :border_glass}),
    border_radius: const({Tokens, :radius_lg}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    min_width: "180px"
  )

  class(:menu_item,
    display: "flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    border_radius: const({Tokens, :radius_md}),
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_primary}),
    cursor: "pointer",
    transition: "background-color 0.15s ease",
    background_color: [
      default: "transparent",
      ":hover": var({Semantic, :fill_muted})
    ]
  )

  class(:menu_divider,
    height: "1px",
    background_color: var({Semantic, :border_subtle}),
    margin_block: var({Space, :"1"}),
    margin_inline: "0"
  )

  class(:menu_item_danger,
    color: var({Semantic, :fill_danger}),
    background_color: [
      default: "transparent",
      ":hover": "color-mix(in oklab, #{var({Semantic, :fill_danger})} 15%, transparent)"
    ]
  )

  # ============================================================================
  # Modal Styles
  # ============================================================================

  class(:modal_base,
    padding: var({Space, :"6"}),
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_lg}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    max_width: "min(400px, calc(100vw - #{var({Space, :"8"})}))"
  )

  class(:modal_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_semibold}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"2"})
  )

  class(:modal_body,
    display: "grid",
    gap: var({Space, :"4"}),
    font_size: const({Tokens, :font_size_base}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed}),
    margin_bottom: var({Space, :"4"})
  )

  class(:modal_actions,
    display: "flex",
    flex_wrap: "wrap",
    gap: var({Space, :"2"}),
    justify_content: "flex-end"
  )

  # ============================================================================
  # Tooltip Styles
  # ============================================================================

  class(:tooltip,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"1"}),
    white_space: "nowrap",
    padding_block: var({Space, :"1"}),
    padding_inline: var({Space, :"2"}),
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    font_size: const({Tokens, :font_size_xs}),
    border_radius: const({Tokens, :radius_md}),
    box_shadow: const({Tokens, :shadow_md})
  )

  # ============================================================================
  # Icon Styles
  # ============================================================================

  class(:icon_base,
    display: "inline-block",
    flex_shrink: "0",
    fill: "none",
    stroke: "currentColor",
    stroke_width: "2",
    stroke_linecap: "round",
    stroke_linejoin: "round"
  )

  class(:icon_sm,
    width: "1rem",
    height: "1rem"
  )

  class(:icon_md,
    width: "1.25rem",
    height: "1.25rem"
  )

  # ============================================================================
  # Input Styles
  # ============================================================================

  class(:input_wrapper,
    margin_bottom: var({Space, :"4"})
  )

  class(:input_label,
    display: "block",
    font_size: const({Tokens, :font_size_sm}),
    font_weight: const({Tokens, :font_weight_medium}),
    color: var({Semantic, :text_primary}),
    margin_bottom: var({Space, :"1"})
  )

  class(:input_field,
    display: "block",
    width: "100%",
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    font_size: const({Tokens, :font_size_base}),
    line_height: const({Tokens, :leading_normal}),
    border_width: "1px",
    border_style: "solid",
    border_color: [
      default: var({Semantic, :border_input}),
      ":focus": var({Semantic, :border_focus})
    ],
    border_radius: const({Tokens, :radius_md}),
    background_color: var({Semantic, :fill_page}),
    color: var({Semantic, :text_primary}),
    outline: "none",
    box_shadow: [
      default: "none",
      ":focus": "0 0 0 2px #{var({Semantic, :focus_ring})}"
    ],
    transition: "border-color 160ms ease, box-shadow 160ms ease"
  )

  class(:input_error,
    border_color: [
      default: var({Semantic, :fill_danger}),
      ":focus": var({Semantic, :fill_danger})
    ],
    box_shadow: [
      default: "none",
      ":focus": "0 0 0 3px color-mix(in oklab, #{var({Semantic, :fill_danger})} 20%, transparent)"
    ]
  )

  class(:error_message,
    display: "flex",
    align_items: "center",
    gap: var({Space, :"1"}),
    margin_top: var({Space, :"1"}),
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_danger})
  )

  # Checkbox
  # Keep it native: the input is the checkbox.

  class(:checkbox_label,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    cursor: "pointer"
  )

  class(:checkbox_text,
    font_size: const({Tokens, :font_size_base}),
    color: var({Semantic, :text_primary})
  )

  class(:checkbox_input,
    appearance: "auto",
    width: "1.25rem",
    height: "1.25rem",
    margin: "0",
    flex_shrink: "0",
    cursor: "pointer",
    accent_color: var({Semantic, :fill_primary}),
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{var({Semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  # ============================================================================
  # Button Styles
  # ============================================================================

  class(:btn_base,
    position: "relative",
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: var({Space, :"2"}),
    padding_block: var({Space, :"3"}),
    padding_inline: var({Space, :"6"}),
    font_size: const({Tokens, :font_size_base}),
    font_weight: const({Tokens, :font_weight_semibold}),
    line_height: const({Tokens, :leading_none}),
    border_radius: const({Tokens, :radius_lg}),
    text_decoration: "none",
    white_space: "nowrap",
    border: "1px solid transparent",
    cursor: "pointer",
    user_select: "none",
    touch_action: "manipulation",
    "-webkit-tap-highlight-color": "transparent",
    "-webkit-font-smoothing": "antialiased",
    "-moz-osx-font-smoothing": "grayscale",
    transition:
      "transform 160ms ease, box-shadow 160ms ease, border-color 160ms ease, background-color 160ms ease, color 160ms ease, filter 160ms ease",
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{var({Semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  class(:btn_sm,
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"4"}),
    font_size: const({Tokens, :font_size_sm}),
    border_radius: const({Tokens, :radius_md})
  )

  class(:btn_primary,
    background_color: [
      default: var({Semantic, :fill_primary}),
      ":hover": var({Semantic, :fill_primary_hover})
    ],
    color: [
      default: var({Semantic, :text_on_primary}),
      ":hover": var({Semantic, :text_on_primary})
    ],
    box_shadow: "none",
    border: "1px solid transparent",
    transform: [
      default: "translateY(0)",
      ":active": "translateY(1px)"
    ]
  )

  class(:btn_secondary,
    background_color: [
      default: var({Semantic, :fill_glass}),
      ":hover": var({Semantic, :fill_secondary})
    ],
    backdrop_filter: "blur(10px) saturate(1.2)",
    color: var({Semantic, :text_primary}),
    border_width: "1px",
    border_style: "solid",
    border_color: [
      default: var({Semantic, :border_glass}),
      ":hover": var({Semantic, :border_focus})
    ],
    box_shadow: [
      default: "0 1px 0 0 #{var({Semantic, :border_glass})}",
      ":hover": "0 10px 30px -26px #{var({Semantic, :shadow_color})}"
    ]
  )

  class(:btn_danger,
    background_color: [
      default: var({Semantic, :fill_danger}),
      ":hover":
        "color-mix(in oklab, #{var({Semantic, :fill_danger})} 85%, #{var({Semantic, :text_primary})})"
    ],
    color: var({Semantic, :text_on_primary}),
    border_color: [
      default: "transparent",
      ":hover": "color-mix(in oklab, #{var({Semantic, :fill_danger})} 45%, transparent)"
    ],
    box_shadow: [
      default:
        "0 18px 60px -48px color-mix(in oklab, #{var({Semantic, :fill_danger})} 35%, transparent), 0 14px 40px -34px #{var({Semantic, :shadow_color})}",
      ":hover":
        "0 26px 70px -52px color-mix(in oklab, #{var({Semantic, :fill_danger})} 40%, transparent), 0 18px 50px -40px #{var({Semantic, :shadow_color_strong})}"
    ]
  )

  class(:btn_ghost,
    background_color: [
      default: "transparent",
      ":hover": var({Semantic, :fill_muted})
    ],
    color: var({Semantic, :text_secondary})
  )

  # ============================================================================
  # Badge Styles
  # ============================================================================

  class(:badge_base,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"1.5"}),
    padding_block: var({Space, :"1"}),
    padding_inline: var({Space, :"2.5"}),
    border_radius: const({Tokens, :radius_full}),
    font_size: const({Tokens, :font_size_xs}),
    font_weight: const({Tokens, :font_weight_medium}),
    line_height: const({Tokens, :leading_none}),
    white_space: "nowrap"
  )

  class(:badge_neutral,
    background_color: var({Semantic, :fill_surface}),
    color: var({Semantic, :text_secondary}),
    border: "1px solid #{var({Semantic, :border_default})}"
  )

  class(:badge_primary,
    background_color: var({Semantic, :fill_primary}),
    color: var({Semantic, :text_on_primary}),
    border: "1px solid transparent"
  )

  class(:badge_outline,
    background_color: "transparent",
    color: var({Semantic, :text_primary}),
    border: "1px solid #{var({Semantic, :border_default})}"
  )

  # ============================================================================
  # Link Styles
  # ============================================================================

  class(:link,
    color: var({Semantic, :text_link}),
    font_weight: const({Tokens, :font_weight_medium}),
    text_decoration: [
      default: "none",
      ":hover": "underline"
    ]
  )

  # ============================================================================
  # Components
  # ============================================================================

  @doc """
  Renders flash notices.
  """
  attr(:id, :string, doc: "the optional id of flash container")
  attr(:flash, :map, default: %{}, doc: "the map of flash messages to display")
  attr(:title, :string, default: nil)
  attr(:kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup")
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block)

  def flash(assigns) do
    assigns = assign_new(assigns, :id, fn -> "flash-#{assigns.kind}" end)

    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> hide("##{@id}")}
      role="alert"
      {css([:flash_container, @class])}
      {@rest}
    >
      <div {css([:flash_alert, @kind == :info && :flash_info, @kind == :error && :flash_error])}>
        <.icon name={if @kind == :info, do: "info", else: "alert"} size={:md} />
        <div {css(:flash_content)}>
          <p :if={@title} {css(:flash_title)}>{@title}</p>
          <p>{msg}</p>
        </div>
        <button type="button" {css(:flash_close)} aria-label={gettext("close")}>
          <.icon name="close" size={:md} />
        </button>
      </div>
    </div>
    """
  end

  @doc """
  Renders a skip link for accessibility.
  """
  attr(:target, :string, default: "#main")
  slot(:inner_block, required: true)

  def skip_link(assigns) do
    ~H"""
    <a href={@target} {css(:skip_link)}>
      {render_slot(@inner_block)}
    </a>
    """
  end

  class(:skip_link,
    position: [default: "absolute", ":focus": "fixed"],
    top: [default: "auto", ":focus": var({Space, :"4"})],
    left: [default: "auto", ":focus": var({Space, :"4"})],
    z_index: [default: "auto", ":focus": "100"],
    width: [default: "1px", ":focus": "auto"],
    height: [default: "1px", ":focus": "auto"],
    padding: [
      default: "0",
      ":focus": "#{var({Space, :"2"})} #{var({Space, :"4"})}"
    ],
    margin: [default: "-1px", ":focus": "0"],
    overflow: [default: "hidden", ":focus": "visible"],
    clip_path: [default: "inset(50%)", ":focus": "none"],
    white_space: [default: "nowrap", ":focus": "normal"],
    border_width: "0",
    background_color: [
      default: "transparent",
      ":focus": var({Semantic, :fill_surface})
    ],
    color: [default: "inherit", ":focus": var({Semantic, :text_primary})],
    border_radius: [default: "0", ":focus": const({Tokens, :radius_lg})],
    box_shadow: [default: "none", ":focus": const({Tokens, :shadow_lg})],
    border: [
      default: "none",
      ":focus": "1px solid #{var({Semantic, :border_default})}"
    ],
    text_decoration: [default: "none", ":focus": "none"],
    font_weight: [default: "normal", ":focus": const({Tokens, :font_weight_semibold})]
  )

  @doc """
  Renders a button.

  If any of `href` / `navigate` / `patch` are present, it renders a link.
  """
  attr(:type, :string, default: "button")
  attr(:size, :atom, default: :md, values: [:md, :sm])

  attr(:variant, :atom,
    default: :primary,
    values: [:primary, :secondary, :danger, :ghost]
  )

  attr(:class, :string, default: nil)

  attr(:rest, :global, include: ~w(
      href
      navigate
      patch
      method
      download
      rel
      target
      disabled
      form
      name
      value
      style
      popovertarget
      popovertargetaction
      phx-click
      phx-disable-with
      phx-target
    ))

  slot(:inner_block, required: true)

  def button(%{rest: rest} = assigns) do
    if rest[:href] || rest[:navigate] || rest[:patch] do
      ~H"""
      <.link
        {css([
          :btn_base,
          @size == :sm && :btn_sm,
          @variant == :primary && :btn_primary,
          @variant == :secondary && :btn_secondary,
          @variant == :danger && :btn_danger,
          @variant == :ghost && :btn_ghost,
          @class
        ])}
        {@rest}
      >
        {render_slot(@inner_block)}
      </.link>
      """
    else
      ~H"""
      <button
        type={@type}
        {css([
          :btn_base,
          @size == :sm && :btn_sm,
          @variant == :primary && :btn_primary,
          @variant == :secondary && :btn_secondary,
          @variant == :danger && :btn_danger,
          @variant == :ghost && :btn_ghost,
          @class
        ])}
        {@rest}
      >
        {render_slot(@inner_block)}
      </button>
      """
    end
  end

  @doc """
  Renders a toast UI element.

  This is just the toast *body* (no popover, no positioning). Use it like a badge.
  """
  attr(:variant, :atom, default: :success, values: [:success, :danger, :neutral])
  attr(:icon, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:role, :string, default: "status")
  attr(:rest, :global)

  slot(:inner_block, required: true)
  slot(:actions)

  def toast(assigns) do
    icon_name =
      assigns.icon ||
        case assigns.variant do
          :success -> "check"
          :danger -> "alert"
          _ -> nil
        end

    assigns = assign(assigns, :icon_name, icon_name)

    ~H"""
    <div
      {css([
        :toast_base,
        @variant == :success && :toast_success,
        @variant == :danger && :toast_danger,
        @class
      ])}
      role={@role}
      {@rest}
    >
      <.icon :if={@icon_name} name={@icon_name} size={:md} {css(:toast_icon)} />
      <span {css(:toast_message)}>{render_slot(@inner_block)}</span>
      <div :if={@actions != []}>
        {render_slot(@actions)}
      </div>
    </div>
    """
  end

  @doc """
  Renders a modal panel UI element.

  This is just the modal *panel* (no popover, no backdrop, no positioning).
  """
  attr(:title, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)
  slot(:actions)

  def modal(assigns) do
    ~H"""
    <div {css([:modal_base, @class])} {@rest}>
      <h3 :if={@title} {css(:modal_title)}>{@title}</h3>

      <div {css(:modal_body)}>
        {render_slot(@inner_block)}
      </div>

      <div :if={@actions != []} {css(:modal_actions)}>
        {render_slot(@actions)}
      </div>
    </div>
    """
  end

  @doc """
  Renders a styled text link.
  """
  attr(:class, :string, default: nil)

  attr(:rest, :global, include: ~w(href navigate patch method download rel target))

  slot(:inner_block, required: true)

  def text_link(assigns) do
    ~H"""
    <.link {css([:link, @class])} {@rest}>
      {render_slot(@inner_block)}
    </.link>
    """
  end

  @doc """
  Renders a tooltip UI element.

  This is intentionally just a styled inline element (like a badge).
  Any anchored positioning or hover/focus behavior belongs in layout/demo code.
  """
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def tooltip(assigns) do
    ~H"""
    <span {css([:tooltip, @class])} {@rest}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  @doc """
  Renders a menu panel UI element.

  This is the menu panel styling only (no popover, no anchoring).
  """
  attr(:id, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def menu(assigns) do
    ~H"""
    <div id={@id} {css([:menu_panel, @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a menu item.
  """
  attr(:danger, :boolean, default: false)
  attr(:class, :string, default: nil)

  attr(:rest, :global,
    include:
      ~w(popovertarget popovertargetaction phx-click phx-target phx-value-id phx-value aria-label role tabindex)
  )

  slot(:inner_block, required: true)

  def menu_item(assigns) do
    ~H"""
    <div {css([:menu_item, @danger && :menu_item_danger, @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a menu divider.
  """
  def menu_divider(assigns) do
    ~H"""
    <div {css(:menu_divider)}></div>
    """
  end

  @doc """
  Renders a label element.
  """
  attr(:for, :any, default: nil)
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def label(assigns) do
    ~H"""
    <label for={@for} {css([:input_label, @class])} {@rest}>
      {render_slot(@inner_block)}
    </label>
    """
  end

  @doc """
  Renders a single error message.
  """
  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def error(assigns) do
    ~H"""
    <p {css([:error_message, @class])} {@rest}>
      <.icon name="alert" size={:sm} />
      {render_slot(@inner_block)}
    </p>
    """
  end

  @doc """
  Renders an input element.

  This is an atomic primitive. Use `<.field>` if you want label + error composition.
  """
  attr(:type, :string, default: "text")
  attr(:name, :any, default: nil)
  attr(:id, :any, default: nil)
  attr(:value, :any, default: nil)
  attr(:checked, :boolean, default: nil)
  attr(:error, :boolean, default: false)
  attr(:class, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)

  attr(:rest, :global,
    include:
      ~w(placeholder required disabled readonly autocomplete min max step minlength maxlength pattern phx-change phx-click phx-hook phx-target phx-debounce phx-value-id phx-value-filter aria-label)
  )

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign_new(:name, fn -> field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(assigns) do
    checked =
      cond do
        assigns.type != "checkbox" ->
          nil

        not is_nil(assigns.checked) ->
          assigns.checked

        true ->
          Form.normalize_value("checkbox", assigns.value)
      end

    value =
      if assigns.type == "checkbox",
        do: assigns.value,
        else: Form.normalize_value(assigns.type, assigns.value)

    assigns =
      assigns
      |> assign(:computed_checked, checked)
      |> assign(:computed_value, value)

    ~H"""
    <input
      type={@type}
      name={@name}
      id={@id}
      value={@computed_value}
      checked={@computed_checked}
      {css([
        @type == "checkbox" && :checkbox_input,
        @type != "checkbox" && :input_field,
        @type != "checkbox" && @error && :input_error,
        @class
      ])}
      {@rest}
    />
    """
  end

  @doc """
  Composed field: label + input + single error.

  This is where composition lives.
  """
  attr(:type, :string, default: "text")
  attr(:label, :string, default: nil)
  attr(:error, :string, default: nil)
  attr(:name, :any, default: nil)
  attr(:id, :any, default: nil)
  attr(:value, :any, default: nil)
  attr(:checked, :boolean, default: nil)
  attr(:class, :string, default: nil)
  attr(:label_class, :string, default: nil)
  attr(:label_text_class, :string, default: nil)
  attr(:input_class, :string, default: nil)
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:rest, :global)

  def field(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign_new(:name, fn -> field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> field()
  end

  def field(assigns) do
    if assigns.type == "checkbox" do
      ~H"""
      <div {css([:input_wrapper, @class])}>
        <label {css([:checkbox_label, @label_class])}>
          <.input
            type="checkbox"
            name={@name}
            id={@id}
            value={@value}
            checked={@checked}
            class={@input_class}
            {@rest}
          />

          <span :if={@label} {css([:checkbox_text, @label_text_class])}>
            {@label}
          </span>
        </label>

        <.error :if={@error}>{@error}</.error>
      </div>
      """
    else
      ~H"""
      <div {css([:input_wrapper, @class])}>
        <.label :if={@label} for={@id} class={@label_class}>
          {@label}
        </.label>

        <.input
          type={@type}
          name={@name}
          id={@id}
          value={@value}
          class={@input_class}
          {@rest}
        />

        <.error :if={@error}>{@error}</.error>
      </div>
      """
    end
  end

  @doc """
  Renders a badge.
  """
  attr(:variant, :atom, default: :neutral, values: [:neutral, :primary, :outline])
  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def badge(assigns) do
    ~H"""
    <span
      {css([
        :badge_base,
        @variant == :neutral && :badge_neutral,
        @variant == :primary && :badge_primary,
        @variant == :outline && :badge_outline,
        @class
      ])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  @doc """
  Renders a simple SVG icon using inline SVGs to avoid dependencies.

  Defaults to applying the built-in icon sizing classes, so call sites
  generally shouldn't need to reference raw `:icon_*` style atoms.
  """
  attr(:name, :string, required: true)
  attr(:size, :atom, default: :md, values: [:sm, :md])
  attr(:class, :string, default: nil)

  def icon(assigns) do
    ~H"""
    <svg
      {css([
        :icon_base,
        @size == :sm && :icon_sm,
        @size == :md && :icon_md,
        @class
      ])}
      viewBox="0 0 24 24"
      aria-hidden="true"
    >
      <%= case @name do %>
        <% "info" -> %>
          <path d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        <% "alert" -> %>
          <path d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        <% "close" -> %>
          <path d="M6 18L18 6M6 6l12 12" />
        <% "check" -> %>
          <path d="M5 13l4 4L19 7" />
        <% "hero-information-circle" -> %>
          <path d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        <% "hero-exclamation-circle" -> %>
          <path d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        <% "hero-x-mark" -> %>
          <path d="M6 18L18 6M6 6l12 12" />
        <% _ -> %>
          <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
      <% end %>
    </svg>
    """
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js, to: selector, time: 300)
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js, to: selector, time: 200)
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(LiveStyleDemoWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(LiveStyleDemoWeb.Gettext, "errors", msg, opts)
    end
  end
end
