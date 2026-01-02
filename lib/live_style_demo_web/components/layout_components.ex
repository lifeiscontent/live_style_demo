defmodule LiveStyleDemoWeb.LayoutComponents do
  @moduledoc """
  Layout components built with LiveStyle.
  """
  use Phoenix.Component
  use LiveStyle

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  # ============================================================================
  # Utilities
  # ============================================================================

  # Removed sr_only - use UIComponents.skip_link instead

  # ============================================================================
  # Container Styles
  # ============================================================================

  # Centered container with max-width and horizontal padding.
  class(:container,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_inline: "clamp(1rem, 4vw, 2rem)"
  )

  # Narrower container for content like articles.
  class(:container_narrow,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_inline: "clamp(1rem, 4vw, 2rem)"
  )

  # ============================================================================
  # Section Styles
  # ============================================================================

  # Standard section with vertical padding.
  class(:section,
    padding_top: var({Space, :"16"}),
    padding_bottom: var({Space, :"16"})
  )

  # ============================================================================
  # Typography Styles
  # ============================================================================

  # Base heading styles.
  class(:heading,
    font_weight: const({Tokens, :font_weight_bold}),
    color: var({Semantic, :text_primary}),
    line_height: const({Tokens, :leading_tight})
  )

  # Base body text styles.
  class(:body_text,
    font_size: const({Tokens, :font_size_base}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  # Utility Text
  class(:text_muted,
    color: var({Semantic, :text_muted})
  )

  class(:text_sm,
    font_size: const({Tokens, :font_size_sm})
  )

  # ============================================================================
  # Flex Layout Helpers
  # ============================================================================

  # Flex container with centered items.
  class(:flex_center,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  # Flex container with space-between.
  class(:flex_between,
    display: "flex",
    align_items: "center",
    justify_content: "space-between"
  )

  # Flex column layout.
  class(:flex_col,
    display: "flex",
    flex_direction: "column"
  )

  # ============================================================================
  # Demo Page Helpers
  # ============================================================================

  class(:demo_section,
    max_width: "64rem",
    margin_bottom: var({Space, :"12"}),
    display: "grid",
    gap: var({Space, :"4"})
  )

  class(:demo_section_title,
    font_size: const({Tokens, :font_size_xl}),
    font_weight: const({Tokens, :font_weight_semibold}),
    line_height: const({Tokens, :leading_tight}),
    letter_spacing: "-0.01em",
    color: var({Semantic, :text_primary})
  )

  class(:demo_section_description,
    max_width: "80ch",
    font_size: const({Tokens, :font_size_base}),
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:demo_code_inline,
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_sm}),
    background_color: var({Semantic, :fill_muted}),
    padding_block: var({Space, :"0.5"}),
    padding_inline: var({Space, :"1.5"}),
    border_radius: const({Tokens, :radius_sm}),
    border: "1px solid #{var({Semantic, :border_subtle})}"
  )

  class(:demo_browser_note,
    display: "inline-flex",
    align_items: "center",
    gap: var({Space, :"2"}),
    padding_block: var({Space, :"2"}),
    padding_inline: var({Space, :"3"}),
    border_radius: const({Tokens, :radius_md}),
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    background_color: "color-mix(in oklab, #{var({Semantic, :fill_warning})} 18%, transparent)",
    border: "1px solid color-mix(in oklab, #{var({Semantic, :fill_warning})} 38%, transparent)"
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
    ~H"""
    <%= case @as do %>
      <% :section -> %>
        <section
          {css([
            @interactive && :card_interactive,
            !@interactive && :card_base,
            @overflow == :visible && :card_overflow_visible,
            @class
          ])}
          {@rest}
        >
          {render_slot(@inner_block)}
        </section>
      <% :article -> %>
        <article
          {css([
            @interactive && :card_interactive,
            !@interactive && :card_base,
            @overflow == :visible && :card_overflow_visible,
            @class
          ])}
          {@rest}
        >
          {render_slot(@inner_block)}
        </article>
      <% _ -> %>
        <div
          {css([
            @interactive && :card_interactive,
            !@interactive && :card_base,
            @overflow == :visible && :card_overflow_visible,
            @class
          ])}
          {@rest}
        >
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
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def heading(assigns) do
    ~H"""
    <%= case @level do %>
      <% 1 -> %>
        <h1 {css([:heading, @class])} {@rest}>{render_slot(@inner_block)}</h1>
      <% 2 -> %>
        <h2 {css([:heading, @class])} {@rest}>{render_slot(@inner_block)}</h2>
      <% 3 -> %>
        <h3 {css([:heading, @class])} {@rest}>{render_slot(@inner_block)}</h3>
      <% 4 -> %>
        <h4 {css([:heading, @class])} {@rest}>{render_slot(@inner_block)}</h4>
      <% 5 -> %>
        <h5 {css([:heading, @class])} {@rest}>{render_slot(@inner_block)}</h5>
      <% _ -> %>
        <h6 {css([:heading, @class])} {@rest}>{render_slot(@inner_block)}</h6>
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
    ~H"""
    <p
      {css([
        :body_text,
        @size == :sm && :text_sm,
        @muted && :text_muted,
        @class
      ])}
      {@rest}
    >
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
    ~H"""
    <section {css([:demo_section, @class])} {@rest}>
      {render_slot(@inner_block)}
    </section>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def demo_section_title(assigns) do
    ~H"""
    <h2 {css([:demo_section_title, @class])} {@rest}>
      {render_slot(@inner_block)}
    </h2>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def demo_section_description(assigns) do
    ~H"""
    <p {css([:demo_section_description, @class])} {@rest}>
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def code_inline(assigns) do
    ~H"""
    <code {css([:demo_code_inline, @class])} {@rest}>
      {render_slot(@inner_block)}
    </code>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def browser_note(assigns) do
    ~H"""
    <div {css([:demo_browser_note, @class])} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ============================================================================
  # Card Styles
  # ============================================================================

  class(:card_base,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    box_shadow:
      "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
    overflow: "hidden"
  )

  class(:card_overflow_visible,
    overflow: "visible"
  )

  class(:card_interactive,
    background_color: var({Semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{var({Semantic, :border_glass})}",
    border_radius: const({Tokens, :radius_2xl}),
    padding: var({Space, :"8"}),
    display: "flex",
    flex_direction: "column",
    gap: var({Space, :"4"}),
    transition: "transform 180ms ease, border-color 180ms ease, box-shadow 180ms ease",
    transform: [default: "translateY(0)", ":hover": "translateY(-4px)"],
    border_color: [
      default: var({Semantic, :border_glass}),
      ":hover": var({Semantic, :border_focus})
    ],
    box_shadow: [
      default:
        "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 22px 70px -62px #{var({Semantic, :shadow_color_strong})}",
      ":hover":
        "0 1px 0 0 #{var({Semantic, :border_glass})}, 0 32px 90px -58px #{var({Semantic, :shadow_color_strong})}"
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
    <header {css([:header_wrapper, @actions != [] && :header_with_actions])}>
      <div>
        <h1 {css(:header_title)}>
          {render_slot(@inner_block)}
        </h1>
        <p :if={@subtitle != []} {css(:header_subtitle)}>
          {render_slot(@subtitle)}
        </p>
      </div>
      <div :if={@actions != []}>{render_slot(@actions)}</div>
    </header>
    """
  end

  class(:header_wrapper,
    padding_bottom: var({Space, :"4"})
  )

  class(:header_with_actions,
    display: "flex",
    align_items: "center",
    justify_content: "space-between",
    gap: var({Space, :"6"})
  )

  class(:header_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_semibold}),
    line_height: const({Tokens, :leading_tight})
  )

  class(:header_subtitle,
    font_size: const({Tokens, :font_size_sm}),
    color: var({Semantic, :text_secondary}),
    margin_top: var({Space, :"1"})
  )
end
