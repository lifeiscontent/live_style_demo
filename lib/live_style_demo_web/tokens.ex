defmodule LiveStyleDemoWeb.Tokens do
  @moduledoc """
  Design tokens for the LiveStyle demo application.

  ## Architecture

  1. `colors` - Raw color palette (hex values, not themed)
  2. `semantic` - Semantic tokens referencing colors (themed for light/dark)

  ## Usage

      use LiveStyle.Sheet

      css_rule :button,
        color: css_var({LiveStyleDemoWeb.Tokens, :semantic, :text_primary}),
        background: css_var({LiveStyleDemoWeb.Tokens, :semantic, :fill_primary}),
        padding: css_var({LiveStyleDemoWeb.Tokens, :space, :"4"})

      # Apply dark theme:
      <div class={css_theme({LiveStyleDemoWeb.Tokens, :semantic, :dark})}>
        ...
      </div>
  """
  use LiveStyle.Tokens
  import LiveStyle.Types

  # ===========================================================================
  # Colors - Raw palette (not themed)
  # ===========================================================================

  css_vars(:colors,
    white: "#ffffff",
    black: "#000000",
    # Gray
    gray_50: "#f9fafb",
    gray_100: "#f3f4f6",
    gray_200: "#e5e7eb",
    gray_300: "#d1d5db",
    gray_400: "#9ca3af",
    gray_500: "#6b7280",
    gray_600: "#4b5563",
    gray_700: "#374151",
    gray_800: "#1f2937",
    gray_900: "#111827",
    gray_950: "#030712",
    # Blue
    blue_50: "#eff6ff",
    blue_400: "#60a5fa",
    blue_500: "#3b82f6",
    blue_600: "#2563eb",
    # Indigo
    indigo_50: "#eef2ff",
    indigo_100: "#e0e7ff",
    indigo_200: "#c7d2fe",
    indigo_300: "#a5b4fc",
    indigo_400: "#818cf8",
    indigo_500: "#6366f1",
    indigo_600: "#4f46e5",
    # Purple
    purple_50: "#faf5ff",
    purple_400: "#c084fc",
    purple_600: "#9333ea",
    # Red
    red_50: "#fef2f2",
    red_100: "#fee2e2",
    red_400: "#f87171",
    red_500: "#ef4444",
    red_600: "#dc2626",
    # Green
    green_50: "#f0fdf4",
    green_100: "#dcfce7",
    green_400: "#4ade80",
    green_500: "#22c55e",
    green_600: "#16a34a",
    # Amber
    amber_50: "#fffbeb",
    amber_200: "#fde68a",
    amber_500: "#f59e0b",
    amber_600: "#d97706"
  )

  # ===========================================================================
  # Semantic - References to colors (themed)
  # ===========================================================================

  css_vars(:semantic,
    # Text
    text_primary: css_var({:colors, :gray_900}),
    text_secondary: css_var({:colors, :gray_600}),
    text_muted: css_var({:colors, :gray_400}),
    text_inverse: css_var({:colors, :white}),
    text_accent: css_var({:colors, :indigo_600}),
    text_link: css_var({:colors, :blue_600}),

    # Fill/background
    fill_primary: css_var({:colors, :indigo_600}),
    fill_primary_hover: css_var({:colors, :indigo_500}),
    fill_secondary: css_var({:colors, :gray_100}),
    fill_secondary_hover: css_var({:colors, :gray_200}),
    fill_accent: css_var({:colors, :purple_600}),
    fill_danger: css_var({:colors, :red_600}),
    fill_success: css_var({:colors, :green_600}),
    fill_warning: css_var({:colors, :amber_500}),
    fill_page: css_var({:colors, :white}),
    fill_surface: css_var({:colors, :gray_50}),
    fill_muted: css_var({:colors, :gray_100}),
    fill_card: css_var({:colors, :white}),

    # Border
    border_default: css_var({:colors, :gray_200}),
    border_subtle: css_var({:colors, :gray_100}),
    border_focus: css_var({:colors, :indigo_500}),
    border_accent: css_var({:colors, :indigo_200})
  )

  # ===========================================================================
  # Dark Theme - Override semantic tokens
  # ===========================================================================

  css_theme(:semantic, :dark,
    # Text
    text_primary: css_var({:colors, :gray_50}),
    text_secondary: css_var({:colors, :gray_300}),
    text_muted: css_var({:colors, :gray_500}),
    text_inverse: css_var({:colors, :gray_900}),
    text_accent: css_var({:colors, :indigo_300}),
    text_link: css_var({:colors, :blue_400}),

    # Fill/background
    fill_primary: css_var({:colors, :indigo_400}),
    fill_primary_hover: css_var({:colors, :indigo_300}),
    fill_secondary: css_var({:colors, :gray_700}),
    fill_secondary_hover: css_var({:colors, :gray_600}),
    fill_accent: css_var({:colors, :purple_400}),
    fill_danger: css_var({:colors, :red_500}),
    fill_success: css_var({:colors, :green_500}),
    fill_warning: css_var({:colors, :amber_500}),
    fill_page: css_var({:colors, :gray_950}),
    fill_surface: css_var({:colors, :gray_900}),
    fill_muted: css_var({:colors, :gray_800}),
    fill_card: css_var({:colors, :gray_800}),

    # Border
    border_default: css_var({:colors, :gray_700}),
    border_subtle: css_var({:colors, :gray_800}),
    border_focus: css_var({:colors, :indigo_400}),
    border_accent: css_var({:colors, :indigo_600})
  )

  # ===========================================================================
  # Spacing
  # ===========================================================================

  css_vars(:space,
    px: "1px",
    "0": "0",
    "1": "0.25rem",
    "2": "0.5rem",
    "3": "0.75rem",
    "4": "1rem",
    "5": "1.25rem",
    "6": "1.5rem",
    "8": "2rem",
    "10": "2.5rem",
    "12": "3rem",
    "16": "4rem"
  )

  # ===========================================================================
  # Typography
  # ===========================================================================

  css_vars(:font,
    sans: "'Inter', system-ui, -apple-system, sans-serif",
    mono: "ui-monospace, monospace"
  )

  css_vars(:font_weight,
    normal: "400",
    medium: "500",
    semibold: "600",
    bold: "700"
  )

  css_vars(:font_size,
    xs: "0.75rem",
    sm: "0.875rem",
    base: "1rem",
    lg: "1.125rem",
    xl: "1.25rem",
    "2xl": "1.5rem",
    "3xl": "1.875rem",
    "4xl": "2.25rem",
    "5xl": "3rem"
  )

  css_vars(:leading,
    none: "1",
    tight: "1.25",
    normal: "1.5",
    relaxed: "1.75"
  )

  # ===========================================================================
  # Border radius
  # ===========================================================================

  css_vars(:radius,
    none: "0",
    sm: "0.125rem",
    default: "0.25rem",
    md: "0.375rem",
    lg: "0.5rem",
    xl: "0.75rem",
    "2xl": "1rem",
    "3xl": "1.5rem",
    full: "9999px"
  )

  # ===========================================================================
  # Shadows
  # ===========================================================================

  css_vars(:shadow,
    sm: "0 1px 2px 0 rgb(0 0 0 / 0.05)",
    default: "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)",
    md: "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
    lg: "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
  )

  # ===========================================================================
  # Animation
  # ===========================================================================

  css_vars(:anim,
    angle: angle("0deg")
  )

  css_keyframes(:spin,
    from: [transform: "rotate(0deg)"],
    to: [transform: "rotate(360deg)"]
  )

  css_keyframes(:pulse,
    "0%, 100%": [opacity: "1"],
    "50%": [opacity: "0.5"]
  )

  # ===========================================================================
  # Constants
  # ===========================================================================

  css_consts(:breakpoint,
    sm: "@media (max-width: 640px)",
    md: "@media (min-width: 641px) and (max-width: 1024px)",
    lg: "@media (min-width: 1025px)"
  )

  css_consts(:z,
    dropdown: "10",
    sticky: "20",
    fixed: "30",
    modal_backdrop: "40",
    modal: "50",
    popover: "60",
    tooltip: "70"
  )

  # ===========================================================================
  # Table Demo - Markers
  # ===========================================================================

  @row_marker LiveStyle.Marker.define(:row)
  def row_marker, do: @row_marker

  # ===========================================================================
  # View Transitions
  # ===========================================================================

  css_keyframes(:vt_scale_in,
    from: [opacity: "0", transform: "scale(0.8)"],
    to: [opacity: "1", transform: "scale(1)"]
  )

  css_keyframes(:vt_scale_out,
    from: [opacity: "1", transform: "scale(1)"],
    to: [opacity: "0", transform: "scale(0.8)"]
  )

  css_keyframes(:vt_fade_in,
    from: [opacity: "0"],
    to: [opacity: "1"]
  )

  css_keyframes(:vt_fade_out,
    from: [opacity: "1"],
    to: [opacity: "0"]
  )

  css_view_transition(:todo_transition,
    old: [
      animation_name: css_keyframes(:vt_scale_out),
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    ],
    new: [
      animation_name: css_keyframes(:vt_scale_in),
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    ]
  )
end
