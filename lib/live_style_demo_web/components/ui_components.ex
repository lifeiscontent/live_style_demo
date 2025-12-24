defmodule LiveStyleDemoWeb.UIComponents do
  @moduledoc """
  Atomic UI components built with LiveStyle.
  """
  use Phoenix.Component
  use LiveStyle.Sheet
  use Gettext, backend: LiveStyleDemoWeb.Gettext

  alias Phoenix.LiveView.JS

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Flash Styles
  # ============================================================================

  css_class(:flash_container,
    display: "block"
  )

  css_class(:flash_alert,
    display: "flex",
    align_items: "flex-start",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    max_width: "24rem"
  )

  css_class(:flash_info,
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_default})
  )

  css_class(:flash_error,
    background_color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 10%, #{css_var({Tokens, :semantic, :fill_surface})})",
    border_width: "1px",
    border_style: "solid",
    border_color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 30%, #{css_var({Tokens, :semantic, :fill_surface})})"
  )

  css_class(:flash_content,
    flex: "1"
  )

  css_class(:flash_title,
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    margin_bottom: css_var({Tokens, :space, :"1"})
  )

  css_class(:flash_close,
    background: "none",
    border: "none",
    cursor: "pointer",
    opacity: "0.5",
    transition: "opacity 0.2s ease"
  )

  # ============================================================================
  # Toast Styles
  # ============================================================================

  css_class(:toast_base,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow: css_const({Tokens, :shadow, :lg}),
    min_width: "min(280px, calc(100vw - #{css_var({Tokens, :space, :"8"})}))",
    max_width: "min(360px, calc(100vw - #{css_var({Tokens, :space, :"8"})}))"
  )

  css_class(:toast_success,
    background_color: css_var({Tokens, :semantic, :fill_success})
  )

  css_class(:toast_danger,
    background_color: css_var({Tokens, :semantic, :fill_danger})
  )

  css_class(:toast_icon,
    flex_shrink: "0"
  )

  css_class(:toast_message,
    flex: "1",
    font_size: css_const({Tokens, :font_size, :sm})
  )

  css_class(:toast_close,
    padding: css_var({Tokens, :space, :"1"}),
    background: "none",
    border: "none",
    cursor: "pointer",
    color: "inherit",
    opacity: %{
      :default => "0.7",
      ":hover" => "1"
    }
  )

  # ============================================================================
  # Menu Styles
  # ============================================================================

  css_class(:menu_panel,
    padding: css_var({Tokens, :space, :"2"}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid",
    border_color: css_var({Tokens, :semantic, :border_glass}),
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    min_width: "180px"
  )

  css_class(:menu_item,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_primary}),
    cursor: "pointer",
    transition: "background-color 0.15s ease",
    background_color: %{
      :default => "transparent",
      ":hover" => css_var({Tokens, :semantic, :fill_muted})
    }
  )

  css_class(:menu_divider,
    height: "1px",
    background_color: css_var({Tokens, :semantic, :border_subtle}),
    margin_block: css_var({Tokens, :space, :"1"}),
    margin_inline: "0"
  )

  css_class(:menu_item_danger,
    color: css_var({Tokens, :semantic, :fill_danger}),
    background_color: %{
      :default => "transparent",
      ":hover" =>
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 15%, transparent)"
    }
  )

  # ============================================================================
  # Modal Styles
  # ============================================================================

  css_class(:modal_base,
    padding: css_var({Tokens, :space, :"6"}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :lg}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    max_width: "min(400px, calc(100vw - #{css_var({Tokens, :space, :"8"})}))"
  )

  css_class(:modal_title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_class(:modal_body,
    display: "grid",
    gap: css_var({Tokens, :space, :"4"}),
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:modal_actions,
    display: "flex",
    flex_wrap: "wrap",
    gap: css_var({Tokens, :space, :"2"}),
    justify_content: "flex-end"
  )

  # ============================================================================
  # Tooltip Styles
  # ============================================================================

  css_class(:tooltip,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"1"}),
    white_space: "nowrap",
    padding_block: css_var({Tokens, :space, :"1"}),
    padding_inline: css_var({Tokens, :space, :"2"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
    font_size: css_const({Tokens, :font_size, :xs}),
    border_radius: css_const({Tokens, :radius, :md}),
    box_shadow: css_const({Tokens, :shadow, :md})
  )

  # ============================================================================
  # Icon Styles
  # ============================================================================

  css_class(:icon_base,
    display: "inline-block",
    flex_shrink: "0",
    fill: "none",
    stroke: "currentColor",
    stroke_width: "2",
    stroke_linecap: "round",
    stroke_linejoin: "round"
  )

  css_class(:icon_sm,
    width: "1rem",
    height: "1rem"
  )

  css_class(:icon_md,
    width: "1.25rem",
    height: "1.25rem"
  )

  # ============================================================================
  # Input Styles
  # ============================================================================

  css_class(:input_wrapper,
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:input_label,
    display: "block",
    font_size: css_const({Tokens, :font_size, :sm}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"1"})
  )

  css_class(:input_field,
    display: "block",
    width: "100%",
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    font_size: css_const({Tokens, :font_size, :base}),
    line_height: css_const({Tokens, :leading, :normal}),
    border_width: "1px",
    border_style: "solid",
    border_color: [
      default: css_var({Tokens, :semantic, :border_input}),
      ":focus": css_var({Tokens, :semantic, :border_focus})
    ],
    border_radius: css_const({Tokens, :radius, :md}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    color: css_var({Tokens, :semantic, :text_primary}),
    outline: "none",
    box_shadow: [
      default: "none",
      ":focus": "0 0 0 2px #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    transition: "border-color 160ms ease, box-shadow 160ms ease"
  )

  css_class(:input_error,
    border_color: [
      default: css_var({Tokens, :semantic, :fill_danger}),
      ":focus": css_var({Tokens, :semantic, :fill_danger})
    ],
    box_shadow: [
      default: "none",
      ":focus":
        "0 0 0 3px color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 20%, transparent)"
    ]
  )

  css_class(:error_message,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"1"}),
    margin_top: css_var({Tokens, :space, :"1"}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_danger})
  )

  # Checkbox
  # Keep it native: the input is the checkbox.

  css_class(:checkbox_label,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    cursor: "pointer"
  )

  css_class(:checkbox_text,
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:checkbox_input,
    appearance: "auto",
    width: "1.25rem",
    height: "1.25rem",
    margin: "0",
    flex_shrink: "0",
    cursor: "pointer",
    accent_color: css_var({Tokens, :semantic, :fill_primary}),
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  # ============================================================================
  # Button Styles
  # ============================================================================

  css_class(:btn_base,
    position: "relative",
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"3"}),
    padding_inline: css_var({Tokens, :space, :"6"}),
    font_size: css_const({Tokens, :font_size, :base}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    line_height: css_const({Tokens, :leading, :none}),
    border_radius: css_const({Tokens, :radius, :lg}),
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
      ":focus-visible": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  css_class(:btn_sm,
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"4"}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md})
  )

  css_class(:btn_primary,
    background_color: [
      default: css_var({Tokens, :semantic, :fill_primary}),
      ":hover": css_var({Tokens, :semantic, :fill_primary_hover})
    ],
    color: [
      default: css_var({Tokens, :semantic, :text_on_primary}),
      ":hover": css_var({Tokens, :semantic, :text_on_primary})
    ],
    box_shadow: "none",
    border: "1px solid transparent",
    transform: [
      default: "translateY(0)",
      ":active": "translateY(1px)"
    ]
  )

  css_class(:btn_secondary,
    background_color: [
      default: css_var({Tokens, :semantic, :fill_glass}),
      ":hover": css_var({Tokens, :semantic, :fill_secondary})
    ],
    backdrop_filter: "blur(10px) saturate(1.2)",
    color: css_var({Tokens, :semantic, :text_primary}),
    border_width: "1px",
    border_style: "solid",
    border_color: [
      default: css_var({Tokens, :semantic, :border_glass}),
      ":hover": css_var({Tokens, :semantic, :border_focus})
    ],
    box_shadow: [
      default: "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}",
      ":hover": "0 10px 30px -26px #{css_var({Tokens, :semantic, :shadow_color})}"
    ]
  )

  css_class(:btn_danger,
    background_color: [
      default: css_var({Tokens, :semantic, :fill_danger}),
      ":hover":
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 85%, #{css_var({Tokens, :semantic, :text_primary})})"
    ],
    color: css_var({Tokens, :semantic, :text_on_primary}),
    border_color: [
      default: "transparent",
      ":hover":
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 45%, transparent)"
    ],
    box_shadow: [
      default:
        "0 18px 60px -48px color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 35%, transparent), 0 14px 40px -34px #{css_var({Tokens, :semantic, :shadow_color})}",
      ":hover":
        "0 26px 70px -52px color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 40%, transparent), 0 18px 50px -40px #{css_var({Tokens, :semantic, :shadow_color_strong})}"
    ]
  )

  css_class(:btn_ghost,
    background_color: [
      default: "transparent",
      ":hover": css_var({Tokens, :semantic, :fill_muted})
    ],
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  # ============================================================================
  # Badge Styles
  # ============================================================================

  css_class(:badge_base,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"1.5"}),
    padding_block: css_var({Tokens, :space, :"1"}),
    padding_inline: css_var({Tokens, :space, :"2.5"}),
    border_radius: css_const({Tokens, :radius, :full}),
    font_size: css_const({Tokens, :font_size, :xs}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    line_height: css_const({Tokens, :leading, :none}),
    white_space: "nowrap"
  )

  css_class(:badge_neutral,
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_default})}"
  )

  css_class(:badge_primary,
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_on_primary}),
    border: "1px solid transparent"
  )

  css_class(:badge_outline,
    background_color: "transparent",
    color: css_var({Tokens, :semantic, :text_primary}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_default})}"
  )

  # ============================================================================
  # Link Styles
  # ============================================================================

  css_class(:link,
    color: css_var({Tokens, :semantic, :text_link}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
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

    class = css_class([:flash_container])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> hide("##{@id}")}
      role="alert"
      class={@computed_class}
      {@rest}
    >
      <div class={
        css_class([:flash_alert, @kind == :info && :flash_info, @kind == :error && :flash_error])
      }>
        <.icon name={if @kind == :info, do: "info", else: "alert"} size={:md} />
        <div class={css_class([:flash_content])}>
          <p :if={@title} class={css_class([:flash_title])}>{@title}</p>
          <p>{msg}</p>
        </div>
        <button type="button" class={css_class([:flash_close])} aria-label={gettext("close")}>
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
    <a href={@target} class={css_class([:skip_link])}>
      {render_slot(@inner_block)}
    </a>
    """
  end

  css_class(:skip_link,
    position: [default: "absolute", ":focus": "fixed"],
    top: [default: "auto", ":focus": css_var({Tokens, :space, :"4"})],
    left: [default: "auto", ":focus": css_var({Tokens, :space, :"4"})],
    z_index: [default: "auto", ":focus": "100"],
    width: [default: "1px", ":focus": "auto"],
    height: [default: "1px", ":focus": "auto"],
    padding: [
      default: "0",
      ":focus": "#{css_var({Tokens, :space, :"2"})} #{css_var({Tokens, :space, :"4"})}"
    ],
    margin: [default: "-1px", ":focus": "0"],
    overflow: [default: "hidden", ":focus": "visible"],
    clip_path: [default: "inset(50%)", ":focus": "none"],
    white_space: [default: "nowrap", ":focus": "normal"],
    border_width: "0",
    background_color: [
      default: "transparent",
      ":focus": css_var({Tokens, :semantic, :fill_surface})
    ],
    color: [default: "inherit", ":focus": css_var({Tokens, :semantic, :text_primary})],
    border_radius: [default: "0", ":focus": css_const({Tokens, :radius, :lg})],
    box_shadow: [default: "none", ":focus": css_const({Tokens, :shadow, :lg})],
    border: [
      default: "none",
      ":focus": "1px solid #{css_var({Tokens, :semantic, :border_default})}"
    ],
    text_decoration: [default: "none", ":focus": "none"],
    font_weight: [default: "normal", ":focus": css_const({Tokens, :font_weight, :semibold})]
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
    class =
      css_class([
        :btn_base,
        assigns.size == :sm && :btn_sm,
        assigns.variant == :primary && :btn_primary,
        assigns.variant == :secondary && :btn_secondary,
        assigns.variant == :danger && :btn_danger,
        assigns.variant == :ghost && :btn_ghost
      ])

    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    if rest[:href] || rest[:navigate] || rest[:patch] do
      ~H"""
      <.link class={@computed_class} {@rest}>
        {render_slot(@inner_block)}
      </.link>
      """
    else
      ~H"""
      <button type={@type} class={@computed_class} {@rest}>
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
    class =
      css_class([
        :toast_base,
        assigns.variant == :success && :toast_success,
        assigns.variant == :danger && :toast_danger
      ])

    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    icon_name =
      assigns.icon ||
        case assigns.variant do
          :success -> "check"
          :danger -> "alert"
          _ -> nil
        end

    assigns =
      assigns
      |> assign(:computed_class, class)
      |> assign(:icon_name, icon_name)

    ~H"""
    <div class={@computed_class} role={@role} {@rest}>
      <.icon :if={@icon_name} name={@icon_name} size={:md} class={css_class([:toast_icon])} />
      <span class={css_class([:toast_message])}>{render_slot(@inner_block)}</span>
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
    class = css_class([:modal_base])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <div class={@computed_class} {@rest}>
      <h3 :if={@title} class={css_class([:modal_title])}>{@title}</h3>

      <div class={css_class([:modal_body])}>
        {render_slot(@inner_block)}
      </div>

      <div :if={@actions != []} class={css_class([:modal_actions])}>
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
    class = css_class([:link])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <.link class={@computed_class} {@rest}>
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
    class = css_class([:tooltip])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <span class={@computed_class} {@rest}>
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
    class = css_class([:menu_panel])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <div id={@id} class={@computed_class} {@rest}>
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
    class = css_class([:menu_item, assigns.danger && :menu_item_danger])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <div class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @doc """
  Renders a menu divider.
  """
  def menu_divider(assigns) do
    ~H"""
    <div class={css_class([:menu_divider])}></div>
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
    class = css_class([:input_label])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <label for={@for} class={@computed_class} {@rest}>
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
    class = css_class([:error_message])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <p class={@computed_class} {@rest}>
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
    class =
      if assigns.type == "checkbox" do
        css_class([:checkbox_input])
      else
        css_class([:input_field, assigns.error && :input_error])
      end

    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    checked =
      cond do
        assigns.type != "checkbox" ->
          nil

        not is_nil(assigns.checked) ->
          assigns.checked

        true ->
          Phoenix.HTML.Form.normalize_value("checkbox", assigns.value)
      end

    value =
      if assigns.type == "checkbox",
        do: assigns.value,
        else: Phoenix.HTML.Form.normalize_value(assigns.type, assigns.value)

    assigns =
      assigns
      |> assign(:computed_class, class)
      |> assign(:computed_checked, checked)
      |> assign(:computed_value, value)

    ~H"""
    <input
      type={@type}
      name={@name}
      id={@id}
      value={@computed_value}
      checked={@computed_checked}
      class={@computed_class}
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
    wrapper_class = css_class([:input_wrapper])

    wrapper_class =
      if assigns.class, do: wrapper_class <> " " <> assigns.class, else: wrapper_class

    assigns = assign(assigns, :computed_wrapper_class, wrapper_class)

    if assigns.type == "checkbox" do
      label_class = css_class([:checkbox_label])

      label_class =
        if assigns.label_class, do: label_class <> " " <> assigns.label_class, else: label_class

      label_text_class = css_class([:checkbox_text])

      label_text_class =
        if assigns.label_text_class,
          do: label_text_class <> " " <> assigns.label_text_class,
          else: label_text_class

      assigns =
        assigns
        |> assign(:computed_label_class, label_class)
        |> assign(:computed_label_text_class, label_text_class)

      ~H"""
      <div class={@computed_wrapper_class}>
        <label class={@computed_label_class}>
          <.input
            type="checkbox"
            name={@name}
            id={@id}
            value={@value}
            checked={@checked}
            class={@input_class}
            {@rest}
          />

          <span :if={@label} class={@computed_label_text_class}>
            {@label}
          </span>
        </label>

        <.error :if={@error}>{@error}</.error>
      </div>
      """
    else
      ~H"""
      <div class={@computed_wrapper_class}>
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
      class={
        css_class([
          :badge_base,
          @variant == :neutral && :badge_neutral,
          @variant == :primary && :badge_primary,
          @variant == :outline && :badge_outline
        ]) <> " " <> (@class || "")
      }
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
    class =
      css_class([
        :icon_base,
        assigns.size == :sm && :icon_sm,
        assigns.size == :md && :icon_md
      ])

    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <svg
      class={@computed_class}
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
