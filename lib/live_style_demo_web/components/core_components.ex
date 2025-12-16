defmodule LiveStyleDemoWeb.CoreComponents do
  @moduledoc """
  Core UI components built with LiveStyle.
  """
  use Phoenix.Component
  use LiveStyle
  use Gettext, backend: LiveStyleDemoWeb.Gettext

  alias Phoenix.LiveView.JS

  # ============================================================================
  # Button Styles
  # ============================================================================

  style(:btn_base, %{
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    padding_top: var(:space_2),
    padding_bottom: var(:space_2),
    padding_left: var(:space_4),
    padding_right: var(:space_4),
    font_size: var(:text_size_sm),
    font_weight: var(:font_weight_medium),
    border_radius: var(:radius_md),
    cursor: %{
      default: "pointer",
      ":disabled": "not-allowed"
    },
    text_decoration: "none",
    border: "none",
    opacity: %{
      default: "1",
      ":hover": "0.9",
      ":disabled": "0.5"
    }
  })

  style(:btn_primary, %{
    background_color: var(:fill_primary),
    color: var(:text_inverse)
  })

  style(:btn_secondary, %{
    background_color: var(:fill_secondary),
    color: var(:text_primary)
  })

  # ============================================================================
  # Flash Styles
  # ============================================================================

  style(:flash_container, %{
    position: "fixed",
    top: var(:space_4),
    right: var(:space_4),
    z_index: "50"
  })

  style(:flash_alert, %{
    display: "flex",
    align_items: "flex-start",
    gap: var(:space_3),
    padding: var(:space_4),
    border_radius: var(:radius_lg),
    box_shadow: var(:shadow_lg),
    max_width: "24rem"
  })

  style(:flash_info, %{
    background_color: var(:color_blue_50),
    border_width: "1px",
    border_style: "solid",
    border_color: var(:color_blue_500)
  })

  style(:flash_error, %{
    background_color: var(:color_red_50),
    border_width: "1px",
    border_style: "solid",
    border_color: var(:color_red_500)
  })

  style(:flash_content, %{
    flex: "1"
  })

  style(:flash_title, %{
    font_weight: var(:font_weight_semibold),
    margin_bottom: var(:space_1)
  })

  style(:flash_close, %{
    background: "none",
    border: "none",
    cursor: "pointer",
    opacity: %{
      default: "0.5",
      ":hover": "1"
    }
  })

  # ============================================================================
  # Icon Styles
  # ============================================================================

  style(:icon_base, %{
    display: "inline-block",
    flex_shrink: "0"
  })

  style(:icon_sm, %{
    width: "1rem",
    height: "1rem"
  })

  style(:icon_md, %{
    width: "1.25rem",
    height: "1.25rem"
  })

  # ============================================================================
  # Input Styles
  # ============================================================================

  style(:input_wrapper, %{
    margin_bottom: var(:space_4)
  })

  style(:input_label, %{
    display: "block",
    font_size: var(:text_size_sm),
    font_weight: var(:font_weight_medium),
    color: var(:text_primary),
    margin_bottom: var(:space_1)
  })

  style(:input_field, %{
    display: "block",
    width: "100%",
    padding_top: var(:space_2),
    padding_bottom: var(:space_2),
    padding_left: var(:space_3),
    padding_right: var(:space_3),
    font_size: var(:text_size_base),
    border_width: "1px",
    border_style: "solid",
    border_color: %{
      default: var(:border_default),
      ":focus": var(:border_focus)
    },
    border_radius: var(:radius_md),
    background_color: var(:fill_page),
    outline: %{
      default: "none",
      ":focus": "none"
    }
  })

  style(:input_error, %{
    border_color: var(:color_red_500)
  })

  style(:error_message, %{
    display: "flex",
    align_items: "center",
    gap: var(:space_1),
    margin_top: var(:space_1),
    font_size: var(:text_size_sm),
    color: var(:color_red_600)
  })

  # ============================================================================
  # Header Styles
  # ============================================================================

  style(:header_wrapper, %{
    padding_bottom: var(:space_4)
  })

  style(:header_with_actions, %{
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: var(:space_6)
  })

  style(:header_title, %{
    font_size: var(:text_size_lg),
    font_weight: var(:font_weight_semibold),
    line_height: var(:leading_tight)
  })

  style(:header_subtitle, %{
    font_size: var(:text_size_sm),
    color: var(:text_secondary),
    margin_top: var(:space_1)
  })

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
      class={style([:flash_container])}
      {@rest}
    >
      <div class={style([:flash_alert, @kind == :info && :flash_info, @kind == :error && :flash_error])}>
        <.icon
          :if={@kind == :info}
          name="hero-information-circle"
          class={style([:icon_base, :icon_md])}
        />
        <.icon
          :if={@kind == :error}
          name="hero-exclamation-circle"
          class={style([:icon_base, :icon_md])}
        />
        <div class={style([:flash_content])}>
          <p :if={@title} class={style([:flash_title])}>{@title}</p>
          <p>{msg}</p>
        </div>
        <button type="button" class={style([:flash_close])} aria-label={gettext("close")}>
          <.icon name="hero-x-mark" class={style([:icon_base, :icon_md])} />
        </button>
      </div>
    </div>
    """
  end

  @doc """
  Renders a button.
  """
  attr(:type, :string, default: "button")
  attr(:variant, :atom, default: :primary, values: [:primary, :secondary])
  attr(:rest, :global, include: ~w(href navigate patch disabled))

  slot(:inner_block, required: true)

  def button(%{rest: rest} = assigns) do
    if rest[:href] || rest[:navigate] || rest[:patch] do
      ~H"""
      <.link class={style([:btn_base, @variant == :primary && :btn_primary, @variant == :secondary && :btn_secondary])} {@rest}>
        {render_slot(@inner_block)}
      </.link>
      """
    else
      ~H"""
      <button type={@type} class={style([:btn_base, @variant == :primary && :btn_primary, @variant == :secondary && :btn_secondary])} {@rest}>
        {render_slot(@inner_block)}
      </button>
      """
    end
  end

  @doc """
  Renders an input with label and error messages.
  """
  attr(:id, :any, default: nil)
  attr(:name, :any)
  attr(:label, :string, default: nil)
  attr(:value, :any)
  attr(:type, :string, default: "text")
  attr(:field, Phoenix.HTML.FormField, default: nil)
  attr(:errors, :list, default: [])
  attr(:rest, :global, include: ~w(placeholder required disabled readonly))

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    errors = if Phoenix.Component.used_input?(field), do: field.errors, else: []

    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(errors, &translate_error(&1)))
    |> assign_new(:name, fn -> field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(assigns) do
    ~H"""
    <div class={style([:input_wrapper])}>
      <label :if={@label} class={style([:input_label])}>{@label}</label>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={style([:input_field, @errors != [] && :input_error])}
        {@rest}
      />
      <p :for={msg <- @errors} class={style([:error_message])}>
        <.icon name="hero-exclamation-circle" class={style([:icon_base, :icon_sm])} />
        {msg}
      </p>
    </div>
    """
  end

  @doc """
  Renders a header with title.
  """
  slot(:inner_block, required: true)
  slot(:subtitle)
  slot(:actions)

  def header(assigns) do
    ~H"""
    <header class={style([:header_wrapper, @actions != [] && :header_with_actions])}>
      <div>
        <h1 class={style([:header_title])}>
          {render_slot(@inner_block)}
        </h1>
        <p :if={@subtitle != []} class={style([:header_subtitle])}>
          {render_slot(@subtitle)}
        </p>
      </div>
      <div :if={@actions != []}>{render_slot(@actions)}</div>
    </header>
    """
  end

  @doc """
  Renders a [Heroicon](https://heroicons.com).
  """
  attr(:name, :string, required: true)
  attr(:class, :string, default: nil)

  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
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
