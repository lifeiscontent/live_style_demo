defmodule LiveStyleDemoWeb.CoreComponents do
  @moduledoc """
  Core UI components built with LiveStyle.
  """
  use Phoenix.Component
  use LiveStyle.Sheet
  use Gettext, backend: LiveStyleDemoWeb.Gettext

  alias Phoenix.LiveView.JS

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Button Styles
  # ============================================================================

  css_class(:btn_base,
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    padding_top: css_var({Tokens, :space, :"2"}),
    padding_bottom: css_var({Tokens, :space, :"2"}),
    padding_left: css_var({Tokens, :space, :"4"}),
    padding_right: css_var({Tokens, :space, :"4"}),
    font_size: css_var({Tokens, :font_size, :sm}),
    font_weight: css_var({Tokens, :font_weight, :medium}),
    border_radius: css_var({Tokens, :radius, :md}),
    cursor: "pointer",
    text_decoration: "none",
    border: "none",
    transition: "all 0.2s ease"
  )

  css_class(:btn_primary,
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_inverse})
  )

  css_class(:btn_secondary,
    background_color: css_var({Tokens, :semantic, :fill_secondary}),
    color: css_var({Tokens, :semantic, :text_primary})
  )

  # ============================================================================
  # Flash Styles
  # ============================================================================

  css_class(:flash_container,
    position: "fixed",
    top: css_var({Tokens, :space, :"4"}),
    right: css_var({Tokens, :space, :"4"}),
    z_index: "50"
  )

  css_class(:flash_alert,
    display: "flex",
    align_items: "flex-start",
    gap: css_var({Tokens, :space, :"3"}),
    padding: css_var({Tokens, :space, :"4"}),
    border_radius: css_var({Tokens, :radius, :lg}),
    box_shadow: css_var({Tokens, :shadow, :lg}),
    max_width: "24rem"
  )

  css_class(:flash_info,
    background_color: css_var({Tokens, :colors, :blue_50}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :colors, :blue_500})
  )

  css_class(:flash_error,
    background_color: css_var({Tokens, :colors, :red_50}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :colors, :red_500})
  )

  css_class(:flash_content,
    flex: "1"
  )

  css_class(:flash_title,
    font_weight: css_var({Tokens, :font_weight, :semibold}),
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
  # Icon Styles
  # ============================================================================

  css_class(:icon_base,
    display: "inline-block",
    flex_shrink: "0"
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
    font_size: css_var({Tokens, :font_size, :sm}),
    font_weight: css_var({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"1"})
  )

  css_class(:input_field,
    display: "block",
    width: "100%",
    padding_top: css_var({Tokens, :space, :"2"}),
    padding_bottom: css_var({Tokens, :space, :"2"}),
    padding_left: css_var({Tokens, :space, :"3"}),
    padding_right: css_var({Tokens, :space, :"3"}),
    font_size: css_var({Tokens, :font_size, :base}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_default}),
    border_radius: css_var({Tokens, :radius, :md}),
    background_color: css_var({Tokens, :semantic, :fill_page}),
    outline: "none",
    transition: "border-color 0.2s ease"
  )

  css_class(:input_error,
    border_color: css_var({Tokens, :colors, :red_500})
  )

  css_class(:error_message,
    display: "flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"1"}),
    margin_top: css_var({Tokens, :space, :"1"}),
    font_size: css_var({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :colors, :red_600})
  )

  # ============================================================================
  # Header Styles
  # ============================================================================

  css_class(:header_wrapper,
    padding_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:header_with_actions,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: css_var({Tokens, :space, :"6"})
  )

  css_class(:header_title,
    font_size: css_var({Tokens, :font_size, :lg}),
    font_weight: css_var({Tokens, :font_weight, :semibold}),
    line_height: css_var({Tokens, :leading, :tight})
  )

  css_class(:header_subtitle,
    font_size: css_var({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    margin_top: css_var({Tokens, :space, :"1"})
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
      class={css_class([:flash_container])}
      {@rest}
    >
      <div class={
        css_class([:flash_alert, @kind == :info && :flash_info, @kind == :error && :flash_error])
      }>
        <.icon
          :if={@kind == :info}
          name="hero-information-circle"
          class={css_class([:icon_base, :icon_md])}
        />
        <.icon
          :if={@kind == :error}
          name="hero-exclamation-circle"
          class={css_class([:icon_base, :icon_md])}
        />
        <div class={css_class([:flash_content])}>
          <p :if={@title} class={css_class([:flash_title])}>{@title}</p>
          <p>{msg}</p>
        </div>
        <button type="button" class={css_class([:flash_close])} aria-label={gettext("close")}>
          <.icon name="hero-x-mark" class={css_class([:icon_base, :icon_md])} />
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
      <.link
        class={
          css_class([
            :btn_base,
            @variant == :primary && :btn_primary,
            @variant == :secondary && :btn_secondary
          ])
        }
        {@rest}
      >
        {render_slot(@inner_block)}
      </.link>
      """
    else
      ~H"""
      <button
        type={@type}
        class={
          css_class([
            :btn_base,
            @variant == :primary && :btn_primary,
            @variant == :secondary && :btn_secondary
          ])
        }
        {@rest}
      >
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
    <div class={css_class([:input_wrapper])}>
      <label :if={@label} class={css_class([:input_label])}>{@label}</label>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={css_class([:input_field, @errors != [] && :input_error])}
        {@rest}
      />
      <p :for={msg <- @errors} class={css_class([:error_message])}>
        <.icon name="hero-exclamation-circle" class={css_class([:icon_base, :icon_sm])} />
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
    <header class={css_class([:header_wrapper, @actions != [] && :header_with_actions])}>
      <div>
        <h1 class={css_class([:header_title])}>
          {render_slot(@inner_block)}
        </h1>
        <p :if={@subtitle != []} class={css_class([:header_subtitle])}>
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
