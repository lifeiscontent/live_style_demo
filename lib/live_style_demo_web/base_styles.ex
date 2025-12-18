defmodule LiveStyleDemoWeb.BaseStyles do
  @moduledoc """
  Shared base styles that can be referenced from other components.

  This module demonstrates LiveStyle's compile-time style composition.
  Use cross-module references like `css_rule({LiveStyleDemoWeb.BaseStyles, :btn_base})`
  in your styles.

  ## Available Styles

  ### Interactive Elements
  - `:interactive` - cursor, transition, outline removal

  ### Buttons
  - `:btn_base` - core button styles

  ### Cards
  - `:card_base` - background, padding, border, shadow

  ### Containers
  - `:container` - centered 80rem max-width container
  - `:container_narrow` - centered 64rem max-width container

  ### Sections
  - `:section` - standard vertical padding

  ### Typography
  - `:heading` - bold text with primary color
  - `:body_text` - secondary text with relaxed line height

  ### Flex Layouts
  - `:flex_center` - centered flex container
  - `:flex_between` - space-between flex container
  - `:flex_col` - flex column layout
  """

  use LiveStyle.Sheet

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  # ============================================================================
  # Interactive Base Styles
  # ============================================================================

  # Base interactive element styles - cursor, transition, and focus outline removal.
  css_rule(:interactive,
    cursor: "pointer",
    transition: "all 0.2s ease",
    outline: "none",
    "-webkit-tap-highlight-color": "transparent"
  )

  # ============================================================================
  # Button Base Styles
  # ============================================================================

  # Core button styles - flex layout, padding, rounded corners.
  css_rule(:btn_base,
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_top: css_var({Tokens, :space, :"3"}),
    padding_bottom: css_var({Tokens, :space, :"3"}),
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"}),
    font_size: css_var({Tokens, :text, :size_base}),
    font_weight: css_var({Tokens, :font, :weight_medium}),
    border_radius: css_var({Tokens, :radius, :lg}),
    text_decoration: "none",
    border: "none",
    cursor: "pointer",
    transition: "all 0.2s ease",
    outline: "none",
    "-webkit-tap-highlight-color": "transparent"
  )

  # ============================================================================
  # Card Base Styles
  # ============================================================================

  # Base card styles - background, padding, rounded corners, border, shadow.
  css_rule(:card_base,
    background_color: css_var({Tokens, :fill, :card}),
    padding: css_var({Tokens, :space, :"6"}),
    border_radius: css_var({Tokens, :radius, :xl}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :border, :subtle}),
    transition: "all 0.2s ease"
  )

  # ============================================================================
  # Container Base Styles
  # ============================================================================

  # Centered container with max-width and horizontal padding.
  css_rule(:container,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"})
  )

  # Narrower container for content like articles.
  css_rule(:container_narrow,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"})
  )

  # ============================================================================
  # Section Base Styles
  # ============================================================================

  # Standard section with vertical padding.
  css_rule(:section,
    padding_top: css_var({Tokens, :space, :"16"}),
    padding_bottom: css_var({Tokens, :space, :"16"})
  )

  # ============================================================================
  # Typography Base Styles
  # ============================================================================

  # Base heading styles.
  css_rule(:heading,
    font_weight: css_var({Tokens, :font, :weight_bold}),
    color: css_var({Tokens, :text, :primary}),
    line_height: css_var({Tokens, :leading, :tight})
  )

  # Base body text styles.
  css_rule(:body_text,
    font_size: css_var({Tokens, :text, :size_base}),
    color: css_var({Tokens, :text, :secondary}),
    line_height: css_var({Tokens, :leading, :relaxed})
  )

  # ============================================================================
  # Flex Layout Helpers
  # ============================================================================

  # Flex container with centered items.
  css_rule(:flex_center,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  # Flex container with space-between.
  css_rule(:flex_between,
    display: "flex",
    align_items: "center",
    justify_content: "space-between"
  )

  # Flex column layout.
  css_rule(:flex_col,
    display: "flex",
    flex_direction: "column"
  )
end
