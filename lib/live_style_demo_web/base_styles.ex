defmodule LiveStyleDemoWeb.BaseStyles do
  @moduledoc """
  Shared base styles that can be referenced from other components.

  This module demonstrates LiveStyle's compile-time style composition.
  Use cross-module references like `css_class({LiveStyleDemoWeb.BaseStyles, :btn_base})`
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
  # Utilities
  # ============================================================================

  css_class(:sr_only,
    position: "absolute",
    width: "1px",
    height: "1px",
    padding: "0",
    margin: "-1px",
    overflow: "hidden",
    clip_path: "inset(50%)",
    white_space: "nowrap",
    border_width: "0"
  )

  # ============================================================================
  # Button Base Styles
  # ============================================================================

  # Core button styles - flex layout, padding, rounded corners.
  # Size: default (use :btn_sm for smaller buttons)
  css_class(:btn_base,
    position: "relative",
    display: "inline-flex",
    align_items: "center",
    justify_content: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_top: css_var({Tokens, :space, :"3"}),
    padding_bottom: css_var({Tokens, :space, :"3"}),
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"}),
    font_size: css_const({Tokens, :font_size, :base}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    line_height: css_const({Tokens, :leading, :none}),
    border_radius: css_const({Tokens, :radius, :lg}),
    text_decoration: "none",
    white_space: "nowrap",
    border: "1px solid transparent",
    cursor: "pointer",
    user_select: "none",
    touch_action: "manipulation",
    "-webkit-tap-highlight-color": "transparent",
    transition:
      "transform 160ms ease, box-shadow 160ms ease, border-color 160ms ease, background-color 160ms ease, color 160ms ease, filter 160ms ease",
    outline: [
      default: "none",
      ":focus-visible": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-visible": "2px"]
  )

  # Small button size modifier
  css_class(:btn_sm,
    padding_top: css_var({Tokens, :space, :"2"}),
    padding_bottom: css_var({Tokens, :space, :"2"}),
    padding_left: css_var({Tokens, :space, :"4"}),
    padding_right: css_var({Tokens, :space, :"4"}),
    font_size: css_const({Tokens, :font_size, :sm}),
    border_radius: css_const({Tokens, :radius, :md})
  )

  # Primary button variant - gradient with glow
  css_class(:btn_primary,
    background_image: css_const({Tokens, :gradient, :primary}),
    color: css_var({Tokens, :semantic, :text_inverse}),
    box_shadow: [
      default:
        "0 18px 50px -36px #{css_var({Tokens, :semantic, :glow_primary})}, 0 14px 40px -34px #{css_var({Tokens, :semantic, :shadow_color})}",
      ":hover":
        "0 26px 70px -44px #{css_var({Tokens, :semantic, :glow_primary})}, 0 18px 50px -40px #{css_var({Tokens, :semantic, :shadow_color_strong})}"
    ],
    filter: [default: "saturate(1.05)", ":hover": "saturate(1.2) contrast(1.05)"],
    transform: [
      default: "translateY(0)",
      ":hover": "translateY(-2px)",
      ":active": "translateY(0)"
    ]
  )

  css_class(:btn_danger,
    background_color: [
      default: css_var({Tokens, :semantic, :fill_danger}),
      ":hover":
        "color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_danger})} 85%, #{css_var({Tokens, :semantic, :text_primary})})"
    ],
    color: css_var({Tokens, :semantic, :text_inverse}),
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

  # Secondary button variant - outlined
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

  # Ghost button variant - minimal
  css_class(:btn_ghost,
    background_color: [
      default: "transparent",
      ":hover": css_var({Tokens, :semantic, :fill_muted})
    ],
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  # ============================================================================
  # Card Base Styles
  # ============================================================================

  # Base card styles - background, padding, rounded corners, border, shadow.
  css_class(:card_base,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(10px) saturate(1.15)",
    padding: css_var({Tokens, :space, :"6"}),
    border_radius: css_const({Tokens, :radius, :xl}),
    border_width: "1px",
    border_style: "solid",
    border_color: css_var({Tokens, :semantic, :border_glass}),
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})}, 0 20px 60px -52px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    transition: "transform 180ms ease, box-shadow 180ms ease, border-color 180ms ease"
  )

  # ============================================================================
  # Container Base Styles
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
  # Section Base Styles
  # ============================================================================

  # Standard section with vertical padding.
  css_class(:section,
    padding_top: css_var({Tokens, :space, :"16"}),
    padding_bottom: css_var({Tokens, :space, :"16"})
  )

  # ============================================================================
  # Typography Base Styles
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
    margin_inline: "auto",
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
end
