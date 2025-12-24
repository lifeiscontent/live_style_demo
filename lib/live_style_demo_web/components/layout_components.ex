defmodule LiveStyleDemoWeb.LayoutComponents do
  @moduledoc """
  Layout components built with LiveStyle.
  """
  use Phoenix.Component
  use LiveStyle.Sheet

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Utilities
  # ============================================================================

  # Removed sr_only - use UIComponents.skip_link instead

  # ============================================================================
  # Container Styles
  # ============================================================================

  # Centered container with max-width and horizontal padding.
  css_class(:container,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_inline: "clamp(1rem, 4vw, 2rem)"
  )

  # Narrower container for content like articles.
  css_class(:container_narrow,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_inline: "clamp(1rem, 4vw, 2rem)"
  )

  # ============================================================================
  # Section Styles
  # ============================================================================

  # Standard section with vertical padding.
  css_class(:section,
    padding_top: css_var({Tokens, :space, :"16"}),
    padding_bottom: css_var({Tokens, :space, :"16"})
  )

  # ============================================================================
  # Typography Styles
  # ============================================================================

  # Base heading styles.
  css_class(:heading,
    font_weight: css_const({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    line_height: css_const({Tokens, :leading, :tight})
  )

  # Base body text styles.
  css_class(:body_text,
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  # Utility Text
  css_class(:text_muted,
    color: css_var({Tokens, :semantic, :text_muted})
  )

  css_class(:text_sm,
    font_size: css_const({Tokens, :font_size, :sm})
  )

  # ============================================================================
  # Flex Layout Helpers
  # ============================================================================

  # Flex container with centered items.
  css_class(:flex_center,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  # Flex container with space-between.
  css_class(:flex_between,
    display: "flex",
    align_items: "center",
    justify_content: "space-between"
  )

  # Flex column layout.
  css_class(:flex_col,
    display: "flex",
    flex_direction: "column"
  )

  # ============================================================================
  # Demo Page Helpers
  # ============================================================================

  css_class(:demo_section,
    max_width: "64rem",
    margin_bottom: css_var({Tokens, :space, :"12"}),
    display: "grid",
    gap: css_var({Tokens, :space, :"4"})
  )

  css_class(:demo_section_title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    line_height: css_const({Tokens, :leading, :tight}),
    letter_spacing: "-0.01em",
    color: css_var({Tokens, :semantic, :text_primary})
  )

  css_class(:demo_section_description,
    max_width: "80ch",
    font_size: css_const({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:demo_code_inline,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    padding_block: css_var({Tokens, :space, :"0.5"}),
    padding_inline: css_var({Tokens, :space, :"1.5"}),
    border_radius: css_const({Tokens, :radius, :sm}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_subtle})}"
  )

  css_class(:demo_browser_note,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"2"}),
    padding_inline: css_var({Tokens, :space, :"3"}),
    border_radius: css_const({Tokens, :radius, :md}),
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    background_color:
      "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_warning})} 18%, transparent)",
    border:
      "1px solid color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_warning})} 38%, transparent)"
  )

  # ============================================================================
  # Components
  # ============================================================================

  @doc """
  Renders a card container.
  """
  attr(:as, :atom, default: :div, values: [:div, :section, :article])
  attr(:interactive, :boolean, default: false)
  attr(:overflow, :atom, default: :hidden, values: [:hidden, :visible])
  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def card(assigns) do
    class =
      css_class([
        assigns.interactive && :card_interactive,
        !assigns.interactive && :card_base,
        assigns.overflow == :visible && :card_overflow_visible
      ])

    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <%= case @as do %>
      <% :section -> %>
        <section class={@computed_class} {@rest}>
          {render_slot(@inner_block)}
        </section>
      <% :article -> %>
        <article class={@computed_class} {@rest}>
          {render_slot(@inner_block)}
        </article>
      <% _ -> %>
        <div class={@computed_class} {@rest}>
          {render_slot(@inner_block)}
        </div>
    <% end %>
    """
  end

  @doc """
  Renders a heading with base heading styles.
  """
  attr(:level, :integer, default: 2, values: [1, 2, 3, 4, 5, 6])
  attr(:class, :string, default: nil)
  attr(:style, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def heading(assigns) do
    class = css_class([:heading])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <%= case @level do %>
      <% 1 -> %>
        <h1 class={@computed_class} style={@style} {@rest}>{render_slot(@inner_block)}</h1>
      <% 2 -> %>
        <h2 class={@computed_class} style={@style} {@rest}>{render_slot(@inner_block)}</h2>
      <% 3 -> %>
        <h3 class={@computed_class} style={@style} {@rest}>{render_slot(@inner_block)}</h3>
      <% 4 -> %>
        <h4 class={@computed_class} style={@style} {@rest}>{render_slot(@inner_block)}</h4>
      <% 5 -> %>
        <h5 class={@computed_class} style={@style} {@rest}>{render_slot(@inner_block)}</h5>
      <% _ -> %>
        <h6 class={@computed_class} style={@style} {@rest}>{render_slot(@inner_block)}</h6>
    <% end %>
    """
  end

  @doc """
  Renders body text.
  """
  attr(:size, :atom, default: :base, values: [:base, :sm])
  attr(:muted, :boolean, default: false)
  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def body_text(assigns) do
    class =
      css_class([
        :body_text,
        assigns.size == :sm && :text_sm,
        assigns.muted && :text_muted
      ])

    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <p class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ----------------------------------------------------------------------------
  # Demo page helper components
  # ----------------------------------------------------------------------------

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def demo_section(assigns) do
    class = css_class([:demo_section])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <section class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </section>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def demo_section_title(assigns) do
    class = css_class([:demo_section_title])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <h2 class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </h2>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def demo_section_description(assigns) do
    class = css_class([:demo_section_description])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <p class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def code_inline(assigns) do
    class = css_class([:demo_code_inline])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <code class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </code>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def browser_note(assigns) do
    class = css_class([:demo_browser_note])
    class = if assigns.class, do: class <> " " <> assigns.class, else: class

    assigns = assign(assigns, :computed_class, class)

    ~H"""
    <div class={@computed_class} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ============================================================================
  # Card Styles
  # ============================================================================

  css_class(:card_base,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  css_class(:card_overflow_visible,
    overflow: "visible"
  )

  css_class(:card_interactive,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    padding: css_var({Tokens, :space, :"8"}),
    display: "flex",
    flex_direction: "column",
    gap: css_var({Tokens, :space, :"4"}),
    transition: "transform 180ms ease, border-color 180ms ease, box-shadow 180ms ease",
    transform: [default: "translateY(0)", ":hover": "translateY(-4px)"],
    border_color: [
      default: css_var({Tokens, :semantic, :border_glass}),
      ":hover": css_var({Tokens, :semantic, :border_focus})
    ],
    box_shadow: [
      default:
        "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 22px 70px -62px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
      ":hover":
        "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 32px 90px -58px #{css_var({Tokens, :semantic, :shadow_color_strong})}"
    ]
  )

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
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :semibold}),
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:header_subtitle,
    font_size: css_const({Tokens, :font_size, :sm}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    margin_top: css_var({Tokens, :space, :"1"})
  )
end
