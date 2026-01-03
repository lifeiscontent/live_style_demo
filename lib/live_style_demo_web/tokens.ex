defmodule LiveStyleDemoWeb.Tokens do
  @moduledoc """
  Design tokens for the LiveStyle demo application.

  ## Architecture

  Tokens are organized into modules by purpose:

  1. `Tokens.Semantic` - Semantic tokens (themed colors, fonts)
  2. `Tokens.Space` - Spacing scale (themed for compact/cozy)
  3. `Tokens.Anim` - Animation tokens
  4. `Tokens` - Constants (font, radius, shadow, etc.), keyframes, markers

  ## Usage

      use LiveStyle

      class :button,
        color: var({LiveStyleDemoWeb.Tokens.Semantic, :text_primary}),
        background: var({LiveStyleDemoWeb.Tokens.Semantic, :fill_primary}),
        padding: var({LiveStyleDemoWeb.Tokens.Space, :"4"})

      # Apply dark theme:
      <div class={theme_class({LiveStyleDemoWeb.Tokens.Semantic, :terminal})}>
        ...
      </div>
  """
  use LiveStyle

  # ===========================================================================
  # Typography
  # ===========================================================================

  consts(
    font_sans: "'Inter', system-ui, -apple-system, sans-serif",
    font_mono: "ui-monospace, monospace"
  )

  consts(
    font_weight_normal: "400",
    font_weight_medium: "500",
    font_weight_semibold: "600",
    font_weight_bold: "700"
  )

  consts(
    font_size_xs: "0.75rem",
    font_size_sm: "0.875rem",
    font_size_base: "1rem",
    font_size_lg: "1.125rem",
    font_size_xl: "1.25rem",
    font_size_2xl: "1.5rem",
    font_size_3xl: "1.875rem",
    font_size_4xl: "2.25rem",
    font_size_5xl: "3rem"
  )

  consts(
    leading_none: "1",
    leading_tight: "1.25",
    leading_normal: "1.5",
    leading_relaxed: "1.75"
  )

  # ===========================================================================
  # Border radius
  # ===========================================================================

  consts(
    radius_none: "0",
    radius_sm: "0.125rem",
    radius_default: "0.25rem",
    radius_md: "0.375rem",
    radius_lg: "0.5rem",
    radius_xl: "0.75rem",
    radius_2xl: "1rem",
    radius_3xl: "1.5rem",
    radius_full: "9999px"
  )

  # ===========================================================================
  # Shadows
  # ===========================================================================

  consts(
    shadow_sm: "0 1px 2px 0 rgb(0 0 0 / 0.05)",
    shadow_default: "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)",
    shadow_md: "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
    shadow_lg: "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
  )

  # ===========================================================================
  # Constants
  # ===========================================================================

  consts(
    breakpoint_sm: "@media (max-width: 640px)",
    breakpoint_md: "@media (min-width: 641px) and (max-width: 1024px)",
    breakpoint_lg: "@media (min-width: 1025px)"
  )

  consts(
    z_dropdown: "10",
    z_sticky: "20",
    z_fixed: "30",
    z_modal_backdrop: "40",
    z_modal: "50",
    z_popover: "60",
    z_tooltip: "70"
  )

  # ===========================================================================
  # Keyframes
  # ===========================================================================

  keyframes(:spin,
    from: [transform: "rotate(0deg)"],
    to: [transform: "rotate(360deg)"]
  )

  keyframes(:pulse,
    "0%, 100%": [opacity: "1"],
    "50%": [opacity: "0.5"]
  )

  # ===========================================================================
  # Table Demo - Markers
  # ===========================================================================

  @row_marker LiveStyle.marker(:row)
  def row_marker, do: @row_marker

  # ===========================================================================
  # View Transitions
  # ===========================================================================

  keyframes(:vt_scale_in,
    from: [opacity: "0", transform: "scale(0.8)"],
    to: [opacity: "1", transform: "scale(1)"]
  )

  keyframes(:vt_scale_out,
    from: [opacity: "1", transform: "scale(1)"],
    to: [opacity: "0", transform: "scale(0.8)"]
  )

  keyframes(:vt_fade_in,
    from: [opacity: "0"],
    to: [opacity: "1"]
  )

  keyframes(:vt_fade_out,
    from: [opacity: "1"],
    to: [opacity: "0"]
  )

  view_transition_class(:todo_transition,
    old: [
      pointer_events: "none",
      animation_name: keyframes(:vt_scale_out),
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    ],
    new: [
      pointer_events: "none",
      animation_name: keyframes(:vt_scale_in),
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    ]
  )
end
