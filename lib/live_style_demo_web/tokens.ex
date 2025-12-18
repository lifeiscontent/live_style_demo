defmodule LiveStyleDemoWeb.Tokens do
  @moduledoc """
  Design tokens for the LiveStyle demo application.

  Uses LiveStyle API:
  - `css_vars/2` defines CSS custom properties
  - `css_consts/2` defines compile-time constants
  - `css_keyframes/2` defines keyframe animations
  - `css_theme/3` defines theme overrides
  - `css_view_transition/2` defines view transition classes

  ## Usage

      # In components:
      use LiveStyle

      css_rule :button,
        color: css_var({LiveStyleDemoWeb.Tokens, :text, :primary}),
        background: css_var({LiveStyleDemoWeb.Tokens, :fill, :primary}),
        padding: css_var({LiveStyleDemoWeb.Tokens, :space, :"4"})
  """
  use LiveStyle.Tokens
  import LiveStyle.Types

  # ===========================================================================
  # Colors - Base palette
  # ===========================================================================

  css_vars(:color,
    white: "#ffffff",
    black: "#000000",
    # Gray scale
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
    blue_100: "#dbeafe",
    blue_200: "#bfdbfe",
    blue_400: "#60a5fa",
    blue_500: "#3b82f6",
    blue_600: "#2563eb",
    blue_700: "#1d4ed8",
    # Indigo (accent)
    indigo_50: "#eef2ff",
    indigo_100: "#e0e7ff",
    indigo_200: "#c7d2fe",
    indigo_300: "#a5b4fc",
    indigo_400: "#818cf8",
    indigo_500: "#6366f1",
    indigo_600: "#4f46e5",
    # Purple
    purple_50: "#faf5ff",
    purple_100: "#f3e8ff",
    purple_200: "#e9d5ff",
    purple_400: "#c084fc",
    purple_500: "#a855f7",
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
    green_200: "#bbf7d0",
    green_400: "#4ade80",
    green_500: "#22c55e",
    green_600: "#16a34a",
    # Amber
    amber_50: "#fffbeb",
    amber_100: "#fef3c7",
    amber_200: "#fde68a",
    amber_500: "#f59e0b",
    amber_600: "#d97706"
  )

  # ===========================================================================
  # Semantic tokens
  # ===========================================================================

  # Text colors + sizes
  css_vars(:text,
    # Colors - reference base colors
    primary: css_var({:color, :gray_900}),
    secondary: css_var({:color, :gray_600}),
    muted: css_var({:color, :gray_400}),
    inverse: css_var({:color, :white}),
    accent: css_var({:color, :indigo_600}),
    link: css_var({:color, :blue_600}),
    # Sizes
    size_xs: "0.75rem",
    size_sm: "0.875rem",
    size_base: "1rem",
    size_lg: "1.125rem",
    size_xl: "1.25rem",
    size_2xl: "1.5rem",
    size_3xl: "1.875rem",
    size_4xl: "2.25rem",
    size_5xl: "3rem"
  )

  # Fill/background colors
  css_vars(:fill,
    primary: css_var({:color, :indigo_600}),
    primary_hover: css_var({:color, :indigo_500}),
    secondary: css_var({:color, :gray_100}),
    secondary_hover: css_var({:color, :gray_200}),
    accent: css_var({:color, :purple_500}),
    danger: css_var({:color, :red_600}),
    success: css_var({:color, :green_600}),
    warning: css_var({:color, :amber_500}),
    page: css_var({:color, :white}),
    surface: css_var({:color, :gray_50}),
    muted: css_var({:color, :gray_100}),
    card: css_var({:color, :white})
  )

  # Border colors
  css_vars(:border,
    default: css_var({:color, :gray_200}),
    subtle: css_var({:color, :gray_100}),
    focus: css_var({:color, :indigo_500}),
    accent: css_var({:color, :indigo_200})
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
    mono: "ui-monospace, monospace",
    weight_normal: "400",
    weight_medium: "500",
    weight_semibold: "600",
    weight_bold: "700"
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

  # Typed variable for CSS animations (allows animating gradient rotation)
  # angle("0deg") generates @property with syntax: '<angle>'
  css_vars(:anim,
    angle: angle("0deg")
  )

  # Keyframes - content-hashed
  css_keyframes(:spin,
    from: [transform: "rotate(0deg)"],
    to: [transform: "rotate(360deg)"]
  )

  css_keyframes(:pulse,
    "0%, 100%": [opacity: "1"],
    "50%": [opacity: "0.5"]
  )

  # ===========================================================================
  # Constants (inlined at build time, not CSS variables)
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
  # Themes
  # ===========================================================================

  # Themes are scoped to specific var groups using css_theme/3:
  # css_theme(var_group, theme_name, overrides)

  css_theme(:fill, :dark,
    primary: "#818cf8",
    primary_hover: "#a5b4fc",
    secondary: "#374151",
    secondary_hover: "#4b5563",
    accent: "#c084fc",
    page: "#030712",
    surface: "#111827",
    muted: "#1f2937",
    card: "#1f2937"
  )

  css_theme(:text, :dark,
    primary: "#f9fafb",
    secondary: "#d1d5db",
    muted: "#6b7280",
    accent: "#a5b4fc",
    link: "#60a5fa"
  )

  css_theme(:border, :dark,
    default: "#374151",
    subtle: "#1f2937",
    focus: "#818cf8",
    accent: "#4f46e5"
  )

  # ===========================================================================
  # View Transitions - Keyframes
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

  # ===========================================================================
  # Table Demo - Markers
  # ===========================================================================

  # ROW marker for table row hover effects (equivalent to StyleX's defineMarker)
  # Usage: <tr class={row_marker()}>
  @row_marker LiveStyle.Marker.define(:row)
  def row_marker, do: @row_marker

  # ===========================================================================
  # View Transitions
  # ===========================================================================

  # View transition class for todo items - scale animation for add/remove
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
