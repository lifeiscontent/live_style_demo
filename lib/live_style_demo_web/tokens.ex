defmodule LiveStyleDemoWeb.Tokens do
  @moduledoc """
  Design tokens for the LiveStyle demo application.

  ## Architecture

  1. `colors` - Raw color palette (hex values, not themed)
  2. `semantic` - Semantic tokens referencing colors (themed for light/dark)

  ## Usage

      use LiveStyle.Sheet

      css_class :button,
        color: css_var({LiveStyleDemoWeb.Tokens, :semantic, :text_primary}),
        background: css_var({LiveStyleDemoWeb.Tokens, :semantic, :fill_primary}),
        padding: css_const({LiveStyleDemoWeb.Tokens, :space, :"4"})

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

  css_consts(:colors,
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
    amber_600: "#d97706",
    # Pink (for gradients)
    pink_500: "#ec4899",
    # Violet
    violet_500: "#8b5cf6",
    violet_600: "#7c3aed"
  )

  # ===========================================================================
  # Semantic - References to colors (themed)
  # ===========================================================================

  # DEFAULT THEME: SWISS (Clean, Minimal, Grid-based)
  # 3 Colors: White, Black, Red (Accent)

  css_vars(:semantic,
    # Text
    text_primary: "#000000",
    text_secondary: "#555555",
    text_muted: "#999999",
    text_inverse: "#ffffff",
    # Dedicated button text tokens for perfect contrast
    text_on_primary: "#ffffff",
    text_on_primary_hover: "#ffffff",
    text_accent: "#ff3e00",
    text_link: "#ff3e00",

    # Fill/background
    fill_primary: "#ff3e00",
    # Swiss Hover: Black (High contrast)
    fill_primary_hover: "#000000",
    fill_secondary: "#f2f2f2",
    fill_secondary_hover: "#e5e5e5",
    fill_accent: "#ff3e00",
    fill_danger: "#ff0000",
    # Minimalist success
    fill_success: "#000000",
    # Minimalist warning
    fill_warning: "#000000",
    fill_page: "#ffffff",
    fill_surface: "#f8f8f8",
    fill_muted: "#f2f2f2",
    fill_card: "#ffffff",

    # Border
    border_default: "#e5e5e5",
    border_subtle: "#f0f0f0",
    border_focus: "#000000",
    border_accent: "#ff3e00",

    # Status / intent
    text_danger: "#ff0000",
    text_success: "#000000",

    # Effects / polish (Simplified for no gradients/transparency issues)
    fill_glass: "#ffffff",
    border_glass: "#e5e5e5",
    shadow_color: "rgba(0,0,0,0.1)",
    shadow_color_strong: "rgba(0,0,0,0.2)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    overlay_backdrop_strong: "rgba(0,0,0,0.6)",
    highlight_primary: "#ff3e00",
    # No gradients/glows
    glow_primary: "transparent",
    glow_secondary: "transparent",
    focus_ring: "#000000",

    # Themeable UI decisions
    font_body: "'Helvetica Neue', Helvetica, Arial, sans-serif",
    font_heading: "'Helvetica Neue', Helvetica, Arial, sans-serif",
    radius_surface: "0px",
    radius_card: "0px",
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "none"
  )

  # ===========================================================================
  # Themes
  # ===========================================================================

  # THEME: TERMINAL (Developer focused, High Contrast)
  # 3 Colors: Black, Green, White (rare accent)

  css_theme(:semantic, :terminal,
    text_primary: "#00ff00",
    text_secondary: "#00aa00",
    text_muted: "#005500",
    text_inverse: "#000000",
    text_on_primary: "#000000",
    text_on_primary_hover: "#000000",
    text_accent: "#ffffff",
    text_link: "#00ff00",
    fill_primary: "#00ff00",
    # Terminal Hover: White (Max contrast with Black text)
    fill_primary_hover: "#ffffff",
    fill_secondary: "#002200",
    fill_secondary_hover: "#003300",
    fill_accent: "#ffffff",
    fill_danger: "#ff0000",
    fill_success: "#00ff00",
    fill_warning: "#ffff00",
    fill_page: "#000000",
    fill_surface: "#001100",
    fill_muted: "#002200",
    fill_card: "#000000",
    border_default: "#004400",
    border_subtle: "#002200",
    border_focus: "#00ff00",
    border_accent: "#ffffff",
    fill_glass: "#000000",
    border_glass: "#00ff00",
    shadow_color: "transparent",
    shadow_color_strong: "transparent",
    focus_ring: "#00ff00",
    font_body: "'Courier New', Courier, monospace",
    font_heading: "'Courier New', Courier, monospace",
    radius_surface: "0",
    radius_card: "0",
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "none"
  )

  # THEME: BLUEPRINT (Technical, Precise)
  # 3 Colors: Blueprint Blue, White Lines, Darker Blue

  css_theme(:semantic, :blueprint,
    text_primary: "#ffffff",
    text_secondary: "#a0c0ff",
    text_muted: "#5070a0",
    text_inverse: "#002060",
    text_on_primary: "#002060",
    text_on_primary_hover: "#002060",
    text_accent: "#ffffff",
    text_link: "#ffffff",
    fill_primary: "#ffffff",
    fill_primary_hover: "#e0e0e0",
    fill_secondary: "#004080",
    fill_secondary_hover: "#005090",
    fill_accent: "#ffffff",
    fill_danger: "#ff6666",
    fill_success: "#66ff66",
    fill_warning: "#ffff66",
    # Blueprint Blue
    fill_page: "#003366",
    fill_surface: "#002b55",
    fill_muted: "#002040",
    fill_card: "#003366",
    # White lines
    border_default: "#ffffff",
    border_subtle: "#5070a0",
    border_focus: "#ffffff",
    border_accent: "#ffffff",
    fill_glass: "#003366",
    border_glass: "#ffffff",
    shadow_color: "rgba(0,0,0,0.2)",
    shadow_color_strong: "rgba(0,0,0,0.4)",
    focus_ring: "#ffffff",
    font_body: "'Consolas', 'Monaco', monospace",
    font_heading: "'Consolas', 'Monaco', monospace",
    radius_surface: "2px",
    radius_card: "2px",
    border_width: "1px",
    # Blueprint style
    border_style: "dashed",
    shadow_surface: "none",
    shadow_card: "4px 4px 0px rgba(0,0,0,0.2)"
  )

  # THEME: SOLAR (Warm, Light, Sophisticated)
  # 3 Colors: Cream, Deep Teal, Magenta

  css_theme(:semantic, :solar,
    text_primary: "#002b36",
    text_secondary: "#586e75",
    text_muted: "#93a1a1",
    text_inverse: "#fdf6e3",
    text_on_primary: "#fdf6e3",
    text_on_primary_hover: "#fdf6e3",
    text_accent: "#d33682",
    text_link: "#d33682",
    fill_primary: "#d33682",
    # Solar Hover: Deep Teal (Base02)
    fill_primary_hover: "#073642",
    fill_secondary: "#eee8d5",
    fill_secondary_hover: "#e3dbbf",
    fill_accent: "#d33682",
    fill_danger: "#dc322f",
    fill_success: "#859900",
    fill_warning: "#b58900",
    # Cream
    fill_page: "#fdf6e3",
    fill_surface: "#eee8d5",
    fill_muted: "#e3dbbf",
    fill_card: "#fdf6e3",
    border_default: "#93a1a1",
    border_subtle: "#e3dbbf",
    border_focus: "#d33682",
    border_accent: "#d33682",
    fill_glass: "#fdf6e3",
    border_glass: "#93a1a1",
    shadow_color: "rgba(0,43,54,0.1)",
    shadow_color_strong: "rgba(0,43,54,0.2)",
    focus_ring: "#d33682",
    font_body: "'Gill Sans', 'Gill Sans MT', Calibri, sans-serif",
    font_heading: "'Gill Sans', 'Gill Sans MT', Calibri, sans-serif",
    radius_surface: "4px",
    radius_card: "4px",
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "2px 2px 6px rgba(0,43,54,0.1)"
  )

  # THEME: NAVY (Dark, Deep, Cyber-lite)
  # 3 Colors: Navy, Light Blue, Teal

  css_theme(:semantic, :navy,
    text_primary: "#e6f1ff",
    text_secondary: "#8892b0",
    text_muted: "#495670",
    text_inverse: "#0a192f",
    text_on_primary: "#0a192f",
    text_on_primary_hover: "#0a192f",
    text_accent: "#64ffda",
    text_link: "#64ffda",
    fill_primary: "#64ffda",
    # Navy Hover: White
    fill_primary_hover: "#ffffff",
    fill_secondary: "#112240",
    fill_secondary_hover: "#233554",
    fill_accent: "#64ffda",
    fill_danger: "#ff5f5f",
    fill_success: "#64ffda",
    fill_warning: "#ffbd2e",
    # Navy
    fill_page: "#0a192f",
    fill_surface: "#112240",
    fill_muted: "#020c1b",
    fill_card: "#112240",
    border_default: "#233554",
    border_subtle: "#1d2d44",
    border_focus: "#64ffda",
    border_accent: "#64ffda",
    fill_glass: "#112240",
    border_glass: "#233554",
    shadow_color: "rgba(2,12,27,0.7)",
    shadow_color_strong: "rgba(2,12,27,0.9)",
    focus_ring: "#64ffda",
    font_body: "'Fira Code', monospace",
    font_heading: "'Fira Code', monospace",
    radius_surface: "4px",
    radius_card: "4px",
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "0 10px 30px -10px rgba(2,12,27,0.7)"
  )

  # THEME: FOREST (Organic, Calm, Dark)
  # 3 Colors: Deep Green, Off-White, Gold

  css_theme(:semantic, :forest,
    text_primary: "#ecfdf5",
    text_secondary: "#a7f3d0",
    text_muted: "#6ee7b7",
    text_inverse: "#022c22",
    text_on_primary: "#022c22",
    text_on_primary_hover: "#022c22",
    text_accent: "#fbbf24",
    text_link: "#fbbf24",
    fill_primary: "#fbbf24",
    # Forest Hover: Off-White
    fill_primary_hover: "#ecfdf5",
    fill_secondary: "#064e3b",
    fill_secondary_hover: "#065f46",
    fill_accent: "#fbbf24",
    fill_danger: "#f87171",
    fill_success: "#fbbf24",
    fill_warning: "#fbbf24",
    # Deep Green
    fill_page: "#022c22",
    # Surface Green
    fill_surface: "#064e3b",
    fill_muted: "#065f46",
    fill_card: "#064e3b",
    border_default: "#065f46",
    border_subtle: "#064e3b",
    border_focus: "#fbbf24",
    border_accent: "#fbbf24",
    fill_glass: "#064e3b",
    border_glass: "#065f46",
    shadow_color: "rgba(0,0,0,0.3)",
    shadow_color_strong: "rgba(0,0,0,0.5)",
    focus_ring: "#fbbf24",
    font_body: "'Georgia', serif",
    font_heading: "'Georgia', serif",
    radius_surface: "8px",
    radius_card: "8px",
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "0 4px 12px rgba(0,0,0,0.3)"
  )

  # THEME: LAVENDER (Soft, Playful, Light)
  # 3 Colors: White/Pale, Deep Purple, Vivid Violet

  css_theme(:semantic, :lavender,
    text_primary: "#4c1d95",
    text_secondary: "#6d28d9",
    text_muted: "#8b5cf6",
    text_inverse: "#ffffff",
    text_on_primary: "#ffffff",
    text_on_primary_hover: "#ffffff",
    text_accent: "#7c3aed",
    text_link: "#7c3aed",
    fill_primary: "#8b5cf6",
    # Lavender Hover: Deep Purple
    fill_primary_hover: "#5b21b6",
    fill_secondary: "#f5f3ff",
    fill_secondary_hover: "#ede9fe",
    fill_accent: "#8b5cf6",
    fill_danger: "#db2777",
    fill_success: "#8b5cf6",
    fill_warning: "#8b5cf6",
    fill_page: "#ffffff",
    fill_surface: "#f5f3ff",
    fill_muted: "#ede9fe",
    fill_card: "#ffffff",
    border_default: "#ddd6fe",
    border_subtle: "#ede9fe",
    border_focus: "#8b5cf6",
    border_accent: "#8b5cf6",
    fill_glass: "#ffffff",
    border_glass: "#ddd6fe",
    shadow_color: "rgba(139, 92, 246, 0.15)",
    shadow_color_strong: "rgba(139, 92, 246, 0.25)",
    focus_ring: "#8b5cf6",
    # Playful font
    font_body: "'Comic Sans MS', 'Chalkboard SE', sans-serif",
    font_heading: "'Comic Sans MS', 'Chalkboard SE', sans-serif",
    radius_surface: "24px",
    radius_card: "24px",
    border_width: "2px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "8px 8px 0px #ddd6fe"
  )

  # THEME: BRUTAL (Raw, Bold, High Contrast)
  # 3 Colors: Silver, Black, Blue

  css_theme(:semantic, :brutal,
    text_primary: "#000000",
    text_secondary: "#333333",
    text_muted: "#666666",
    text_inverse: "#ffffff",
    text_on_primary: "#ffffff",
    text_on_primary_hover: "#ffffff",
    text_accent: "#2563eb",
    text_link: "#2563eb",
    fill_primary: "#2563eb",
    # Brutal Hover: Black (High contrast)
    fill_primary_hover: "#000000",
    fill_secondary: "#ffffff",
    fill_secondary_hover: "#f3f4f6",
    fill_accent: "#2563eb",
    fill_danger: "#ef4444",
    fill_success: "#2563eb",
    fill_warning: "#2563eb",
    fill_page: "#e5e7eb",
    fill_surface: "#ffffff",
    fill_muted: "#d1d5db",
    fill_card: "#ffffff",
    border_default: "#000000",
    border_subtle: "#000000",
    border_focus: "#2563eb",
    border_accent: "#2563eb",
    fill_glass: "#ffffff",
    border_glass: "#000000",
    shadow_color: "#000000",
    shadow_color_strong: "#000000",
    focus_ring: "#2563eb",
    font_body: "'Courier New', Courier, monospace",
    font_heading: "'Impact', 'Arial Black', sans-serif",
    radius_surface: "0px",
    radius_card: "0px",
    border_width: "2px",
    border_style: "solid",
    shadow_surface: "4px 4px 0px #000000",
    shadow_card: "6px 6px 0px #000000"
  )

  # ===========================================================================
  # Spacing
  # ===========================================================================

  css_vars(:space,
    "0.5": "0.125rem",
    "1": "0.25rem",
    "1.5": "0.375rem",
    "2": "0.5rem",
    "2.5": "0.625rem",
    "3": "0.75rem",
    "3.5": "0.875rem",
    "4": "1rem",
    "5": "1.25rem",
    "6": "1.5rem",
    "8": "2rem",
    "10": "2.5rem",
    "12": "3rem",
    "16": "4rem"
  )

  css_theme(:space, :compact,
    "0.5": "0.1rem",
    "1": "0.2rem",
    "1.5": "0.3rem",
    "2": "0.4rem",
    "2.5": "0.5rem",
    "3": "0.6rem",
    "3.5": "0.7rem",
    "4": "0.8rem",
    "5": "1rem",
    "6": "1.2rem",
    "8": "1.6rem",
    "10": "2rem",
    "12": "2.4rem",
    "16": "3.2rem"
  )

  css_theme(:space, :cozy,
    "0.5": "0.15rem",
    "1": "0.3rem",
    "1.5": "0.45rem",
    "2": "0.65rem",
    "2.5": "0.75rem",
    "3": "0.9rem",
    "3.5": "1.05rem",
    "4": "1.2rem",
    "5": "1.5rem",
    "6": "1.8rem",
    "8": "2.4rem",
    "10": "3rem",
    "12": "3.6rem",
    "16": "4.8rem"
  )

  # ===========================================================================
  # Typography
  # ===========================================================================

  css_consts(:font,
    sans: "'Inter', system-ui, -apple-system, sans-serif",
    mono: "ui-monospace, monospace"
  )

  css_consts(:font_weight,
    normal: "400",
    medium: "500",
    semibold: "600",
    bold: "700"
  )

  css_consts(:font_size,
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

  css_consts(:leading,
    none: "1",
    tight: "1.25",
    normal: "1.5",
    relaxed: "1.75"
  )

  # ===========================================================================
  # Border radius
  # ===========================================================================

  css_consts(:radius,
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

  css_consts(:shadow,
    sm: "0 1px 2px 0 rgb(0 0 0 / 0.05)",
    default: "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)",
    md: "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
    lg: "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
  )

  # ===========================================================================
  # Animation
  # ===========================================================================

  css_vars(:anim,
    angle: angle("0deg"),
    hue: angle("260deg"),
    chroma: number(0.22)
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
      pointer_events: "none",
      animation_name: css_keyframes(:vt_scale_out),
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    ],
    new: [
      pointer_events: "none",
      animation_name: css_keyframes(:vt_scale_in),
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    ]
  )
end
