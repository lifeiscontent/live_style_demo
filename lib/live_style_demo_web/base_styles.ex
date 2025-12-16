defmodule LiveStyleDemoWeb.BaseStyles do
  @moduledoc """
  Shared base styles that can be included in other components.

  This module demonstrates LiveStyle's compile-time style composition feature.
  Use `__include__: [{LiveStyleDemoWeb.BaseStyles, :style_name}]` in your styles
  to copy these base properties at compile time.

  ## Available Styles

  ### Interactive Elements
  - `:interactive` - cursor, transition, outline removal

  ### Buttons
  - `:btn_base` - core button styles (includes interactive)

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

  use LiveStyle

  # ============================================================================
  # Interactive Base Styles
  # ============================================================================

  # Base interactive element styles - cursor, transition, and focus outline removal.
  style(:interactive,
    cursor: "pointer",
    transition: "all 0.2s ease",
    outline: "none",
    "-webkit-tap-highlight-color": "transparent"
  )

  # ============================================================================
  # Button Base Styles
  # ============================================================================

  # Core button styles - flex layout, padding, rounded corners.
  # Uses self-reference to include :interactive styles.
  style(:btn_base,
    __include__: [:interactive],
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: var(:space_2),
    padding_top: var(:space_3),
    padding_bottom: var(:space_3),
    padding_left: var(:space_6),
    padding_right: var(:space_6),
    font_size: var(:text_size_base),
    font_weight: var(:font_weight_medium),
    border_radius: var(:radius_lg),
    text_decoration: "none",
    border: "none"
  )

  # ============================================================================
  # Card Base Styles
  # ============================================================================

  # Base card styles - background, padding, rounded corners, border, shadow.
  style(:card_base,
    background_color: var(:fill_card),
    padding: var(:space_6),
    border_radius: var(:radius_xl),
    border_width: "1px",
    border_style: "solid",
    border_color: var(:border_subtle),
    transition: "all 0.2s ease"
  )

  # ============================================================================
  # Container Base Styles
  # ============================================================================

  # Centered container with max-width and horizontal padding.
  style(:container,
    max_width: "80rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: var(:space_6),
    padding_right: var(:space_6)
  )

  # Narrower container for content like articles.
  style(:container_narrow,
    max_width: "64rem",
    margin_left: "auto",
    margin_right: "auto",
    padding_left: var(:space_6),
    padding_right: var(:space_6)
  )

  # ============================================================================
  # Section Base Styles
  # ============================================================================

  # Standard section with vertical padding.
  style(:section,
    padding_top: var(:space_16),
    padding_bottom: var(:space_16)
  )

  # ============================================================================
  # Typography Base Styles
  # ============================================================================

  # Base heading styles.
  style(:heading,
    font_weight: var(:font_weight_bold),
    color: var(:text_primary),
    line_height: var(:leading_tight)
  )

  # Base body text styles.
  style(:body_text,
    font_size: var(:text_size_base),
    color: var(:text_secondary),
    line_height: var(:leading_relaxed)
  )

  # ============================================================================
  # Flex Layout Helpers
  # ============================================================================

  # Flex container with centered items.
  style(:flex_center,
    display: "flex",
    align_items: "center",
    justify_content: "center"
  )

  # Flex container with space-between.
  style(:flex_between,
    display: "flex",
    align_items: "center",
    justify_content: "space-between"
  )

  # Flex column layout.
  style(:flex_col,
    display: "flex",
    flex_direction: "column"
  )
end
