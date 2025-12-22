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
  # Gradients - Tokenized gradient colors
  # ===========================================================================

  css_consts(:gradient,
    # Primary brand gradient (indigo -> violet -> pink)
    primary:
      "linear-gradient(135deg, #{css_const({:colors, :indigo_500})} 0%, #{css_const({:colors, :violet_500})} 60%, #{css_const({:colors, :pink_500})} 100%)",
    # Hero gradient (used for text gradients)
    hero:
      "linear-gradient(135deg, #{css_const({:colors, :indigo_500})} 0%, #{css_const({:colors, :violet_500})} 50%, #{css_const({:colors, :pink_500})} 100%)",
    # Accent gradient (used for demo highlights)
    accent:
      "linear-gradient(135deg, #{css_const({:colors, :indigo_400})} 0%, #{css_const({:colors, :purple_600})} 100%)"
  )

  # ===========================================================================
  # Semantic - References to colors (themed)
  # ===========================================================================

  css_vars(:semantic,
    # Text
    text_primary: css_const({:colors, :gray_900}),
    text_secondary: css_const({:colors, :gray_600}),
    text_muted: css_const({:colors, :gray_400}),
    text_inverse: css_const({:colors, :white}),
    text_accent: css_const({:colors, :indigo_600}),
    text_link: css_const({:colors, :blue_600}),

    # Fill/background
    fill_primary: css_const({:colors, :indigo_600}),
    fill_primary_hover: css_const({:colors, :indigo_500}),
    fill_secondary: css_const({:colors, :gray_100}),
    fill_secondary_hover: css_const({:colors, :gray_200}),
    fill_accent: css_const({:colors, :purple_600}),
    fill_danger: css_const({:colors, :red_600}),
    fill_success: css_const({:colors, :green_600}),
    fill_warning: css_const({:colors, :amber_500}),
    fill_page: css_const({:colors, :white}),
    fill_surface: css_const({:colors, :gray_50}),
    fill_muted: css_const({:colors, :gray_100}),
    fill_card: css_const({:colors, :white}),

    # Border
    border_default: css_const({:colors, :gray_200}),
    border_subtle: css_const({:colors, :gray_100}),
    border_focus: css_const({:colors, :indigo_500}),
    border_accent: css_const({:colors, :indigo_200}),

    # Status / intent (derived so themes "just work")
    text_danger: css_var({:semantic, :fill_danger}),
    text_success: css_var({:semantic, :fill_success}),
    fill_tint_info:
      "color-mix(in oklab, #{css_var({:semantic, :text_link})} 12%, #{css_var({:semantic, :fill_glass})})",
    border_info:
      "color-mix(in oklab, #{css_var({:semantic, :text_link})} 45%, #{css_var({:semantic, :border_glass})})",
    fill_tint_success:
      "color-mix(in oklab, #{css_var({:semantic, :fill_success})} 12%, #{css_var({:semantic, :fill_glass})})",
    border_success:
      "color-mix(in oklab, #{css_var({:semantic, :fill_success})} 45%, #{css_var({:semantic, :border_glass})})",
    fill_tint_danger:
      "color-mix(in oklab, #{css_var({:semantic, :fill_danger})} 12%, #{css_var({:semantic, :fill_glass})})",
    border_danger:
      "color-mix(in oklab, #{css_var({:semantic, :fill_danger})} 45%, #{css_var({:semantic, :border_glass})})",

    # Effects / polish
    fill_glass: "color-mix(in oklab, #{css_const({:colors, :white})} 72%, transparent)",
    border_glass: "color-mix(in oklab, #{css_const({:colors, :gray_200})} 55%, transparent)",
    shadow_color: "rgb(0 0 0 / 0.14)",
    shadow_color_strong: "rgb(0 0 0 / 0.28)",
    overlay_backdrop: "rgb(0 0 0 / 0.18)",
    overlay_backdrop_strong: "rgb(0 0 0 / 0.35)",
    highlight_primary:
      "color-mix(in oklab, #{css_const({:colors, :indigo_600})} 18%, transparent)",
    glow_primary: "color-mix(in oklab, #{css_const({:colors, :indigo_500})} 45%, transparent)",
    glow_secondary: "color-mix(in oklab, #{css_const({:colors, :violet_500})} 45%, transparent)",
    focus_ring: "color-mix(in oklab, #{css_const({:colors, :indigo_500})} 55%, transparent)",

    # Themeable UI decisions
    font_body: css_const({:font, :sans}),
    font_heading: css_const({:font, :sans}),
    radius_surface: css_const({:radius, :"2xl"}),
    radius_card: css_const({:radius, :xl}),
    border_width: "1px",
    border_style: "solid",
    shadow_surface: css_const({:shadow, :md}),
    shadow_card: css_const({:shadow, :lg})
  )

  # ===========================================================================
  # Dark Theme - Override semantic tokens
  # ===========================================================================

  css_theme(:semantic, :dark,
    # Text
    text_primary: css_const({:colors, :gray_50}),
    text_secondary: css_const({:colors, :gray_300}),
    text_muted: css_const({:colors, :gray_500}),
    text_inverse: css_const({:colors, :gray_900}),
    text_accent: css_const({:colors, :indigo_300}),
    text_link: css_const({:colors, :blue_400}),

    # Fill/background
    fill_primary: css_const({:colors, :indigo_400}),
    fill_primary_hover: css_const({:colors, :indigo_300}),
    fill_secondary: css_const({:colors, :gray_700}),
    fill_secondary_hover: css_const({:colors, :gray_600}),
    fill_accent: css_const({:colors, :purple_400}),
    fill_danger: css_const({:colors, :red_500}),
    fill_success: css_const({:colors, :green_500}),
    fill_warning: css_const({:colors, :amber_500}),
    fill_page: css_const({:colors, :gray_950}),
    fill_surface: css_const({:colors, :gray_900}),
    fill_muted: css_const({:colors, :gray_800}),
    fill_card: css_const({:colors, :gray_800}),

    # Border
    border_default: css_const({:colors, :gray_700}),
    border_subtle: css_const({:colors, :gray_800}),
    border_focus: css_const({:colors, :indigo_400}),
    border_accent: css_const({:colors, :indigo_600}),

    # Effects / polish
    fill_glass: "color-mix(in oklab, #{css_const({:colors, :gray_900})} 72%, transparent)",
    border_glass: "color-mix(in oklab, #{css_const({:colors, :gray_700})} 55%, transparent)",
    shadow_color: "rgb(0 0 0 / 0.55)",
    shadow_color_strong: "rgb(0 0 0 / 0.75)",
    overlay_backdrop: "rgb(0 0 0 / 0.55)",
    overlay_backdrop_strong: "rgb(0 0 0 / 0.75)",
    highlight_primary:
      "color-mix(in oklab, #{css_const({:colors, :indigo_400})} 20%, transparent)",
    glow_primary: "color-mix(in oklab, #{css_const({:colors, :indigo_400})} 55%, transparent)",
    glow_secondary: "color-mix(in oklab, #{css_const({:colors, :violet_500})} 55%, transparent)",
    focus_ring: "color-mix(in oklab, #{css_const({:colors, :indigo_400})} 60%, transparent)",

    # Themeable UI decisions
    font_body: css_const({:font, :sans}),
    font_heading: css_const({:font, :sans}),
    radius_surface: css_const({:radius, :"2xl"}),
    radius_card: css_const({:radius, :xl}),
    border_width: "1px",
    border_style: "solid",
    shadow_surface: css_const({:shadow, :md}),
    shadow_card: css_const({:shadow, :lg})
  )

  # ===========================================================================
  # Zen Garden Themes (demo)
  # ===========================================================================

  css_theme(:semantic, :zen_brutalist,
    text_primary: css_const({:colors, :black}),
    text_secondary: css_const({:colors, :gray_800}),
    text_muted: css_const({:colors, :gray_600}),
    text_inverse: css_const({:colors, :white}),
    text_accent: css_const({:colors, :black}),
    text_link: css_const({:colors, :black}),
    fill_primary: css_const({:colors, :black}),
    fill_primary_hover: css_const({:colors, :gray_900}),
    fill_accent: css_const({:colors, :black}),
    fill_secondary: css_const({:colors, :gray_100}),
    fill_secondary_hover: css_const({:colors, :gray_200}),
    fill_page: css_const({:colors, :white}),
    fill_surface: css_const({:colors, :white}),
    fill_muted: css_const({:colors, :gray_100}),
    fill_card: css_const({:colors, :white}),
    border_default: css_const({:colors, :black}),
    border_subtle: css_const({:colors, :black}),
    border_focus: css_const({:colors, :black}),
    border_accent: css_const({:colors, :black}),
    fill_glass: css_const({:colors, :white}),
    border_glass: css_const({:colors, :black}),
    shadow_color: "transparent",
    shadow_color_strong: "transparent",
    overlay_backdrop: "rgb(0 0 0 / 0.08)",
    overlay_backdrop_strong: "rgb(0 0 0 / 0.16)",
    highlight_primary: "color-mix(in oklab, #{css_const({:colors, :black})} 12%, transparent)",
    glow_primary: "transparent",
    glow_secondary: "transparent",
    focus_ring: "transparent",
    font_body: css_const({:font, :mono}),
    font_heading: css_const({:font, :mono}),
    radius_surface: css_const({:radius, :none}),
    radius_card: css_const({:radius, :none}),
    border_width: "2px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "none"
  )

  css_theme(:semantic, :zen_paper,
    text_primary: "oklch(21% 0.03 50)",
    text_secondary: "oklch(36% 0.03 55)",
    text_muted: "oklch(52% 0.03 55)",
    text_inverse: "oklch(98% 0.01 80)",
    text_accent: "oklch(42% 0.12 55)",
    text_link: "oklch(42% 0.12 55)",
    fill_primary: "oklch(42% 0.12 55)",
    fill_primary_hover: "oklch(38% 0.12 55)",
    fill_accent: "oklch(42% 0.12 55)",
    fill_secondary: css_const({:colors, :amber_50}),
    fill_secondary_hover: css_const({:colors, :amber_200}),
    fill_page: "oklch(98% 0.01 80)",
    fill_surface: "oklch(97% 0.02 80)",
    fill_muted: "oklch(94% 0.02 80)",
    fill_card: "oklch(99% 0.01 80)",
    border_default: "oklch(88% 0.03 80)",
    border_subtle: "oklch(92% 0.02 80)",
    border_focus: "oklch(62% 0.10 55)",
    border_accent: "oklch(88% 0.03 80)",
    fill_glass: "color-mix(in oklab, oklch(99% 0.01 80) 78%, transparent)",
    border_glass: "color-mix(in oklab, oklch(88% 0.03 80) 70%, transparent)",
    glow_primary: "color-mix(in oklab, oklch(62% 0.10 55) 30%, transparent)",
    glow_secondary: "color-mix(in oklab, oklch(62% 0.10 55) 18%, transparent)",
    highlight_primary: "color-mix(in oklab, oklch(62% 0.10 55) 16%, transparent)",
    focus_ring: "color-mix(in oklab, oklch(62% 0.10 55) 40%, transparent)",
    font_body: "ui-serif, Georgia, serif",
    font_heading: "ui-serif, Georgia, serif",
    radius_surface: css_const({:radius, :"3xl"}),
    radius_card: css_const({:radius, :"2xl"}),
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "0 18px 40px -30px rgb(0 0 0 / 0.18)",
    shadow_card: "0 22px 60px -44px rgb(0 0 0 / 0.22)"
  )

  css_theme(:semantic, :zen_neon,
    text_primary: css_const({:colors, :gray_50}),
    text_secondary: "rgb(203 213 225 / 0.9)",
    text_muted: "rgb(148 163 184 / 0.9)",
    text_inverse: css_const({:colors, :gray_950}),
    text_accent: css_const({:colors, :pink_500}),
    text_link: css_const({:colors, :pink_500}),
    fill_primary: css_const({:colors, :pink_500}),
    fill_primary_hover: "color-mix(in oklab, #{css_const({:colors, :pink_500})} 82%, white)",
    fill_accent: css_const({:colors, :violet_500}),
    fill_secondary: "rgb(30 41 59 / 0.75)",
    fill_secondary_hover: "rgb(51 65 85 / 0.75)",
    fill_page: css_const({:colors, :gray_950}),
    fill_surface: "rgb(2 6 23)",
    fill_muted: "rgb(15 23 42)",
    fill_card: "rgb(15 23 42 / 0.7)",
    border_default: "rgb(148 163 184 / 0.18)",
    border_subtle: "rgb(148 163 184 / 0.12)",
    border_focus: css_const({:colors, :pink_500}),
    border_accent: "rgb(236 72 153 / 0.3)",
    fill_glass: "rgb(15 23 42 / 0.55)",
    border_glass: "rgb(148 163 184 / 0.18)",
    shadow_color: "rgb(0 0 0 / 0.7)",
    shadow_color_strong: "rgb(0 0 0 / 0.85)",
    overlay_backdrop: "rgb(0 0 0 / 0.62)",
    overlay_backdrop_strong: "rgb(0 0 0 / 0.78)",
    highlight_primary: "color-mix(in oklab, #{css_const({:colors, :pink_500})} 16%, transparent)",
    glow_primary: "color-mix(in oklab, #{css_const({:colors, :pink_500})} 55%, transparent)",
    glow_secondary: "color-mix(in oklab, #{css_const({:colors, :violet_500})} 55%, transparent)",
    focus_ring: "color-mix(in oklab, #{css_const({:colors, :pink_500})} 60%, transparent)",
    font_body: css_const({:font, :sans}),
    font_heading: css_const({:font, :sans}),
    radius_surface: css_const({:radius, :"3xl"}),
    radius_card: css_const({:radius, :"2xl"}),
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "0 26px 80px -60px rgb(0 0 0 / 0.85)",
    shadow_card: "0 30px 90px -70px rgb(0 0 0 / 0.9)"
  )

  css_theme(:semantic, :zen_terminal,
    text_primary: css_const({:colors, :green_400}),
    text_secondary: css_const({:colors, :green_100}),
    text_muted: "rgb(34 197 94 / 0.55)",
    text_inverse: css_const({:colors, :black}),
    text_accent: css_const({:colors, :green_400}),
    text_link: css_const({:colors, :green_400}),
    fill_primary: css_const({:colors, :green_500}),
    fill_primary_hover: css_const({:colors, :green_400}),
    fill_accent: css_const({:colors, :green_400}),
    fill_secondary: "rgb(0 0 0 / 0.65)",
    fill_secondary_hover: "rgb(0 0 0 / 0.5)",
    fill_page: css_const({:colors, :black}),
    fill_surface: "rgb(0 0 0)",
    fill_muted: "rgb(0 0 0 / 0.75)",
    fill_card: "rgb(0 0 0 / 0.7)",
    border_default: "rgb(34 197 94 / 0.35)",
    border_subtle: "rgb(34 197 94 / 0.2)",
    border_focus: css_const({:colors, :green_400}),
    border_accent: "rgb(34 197 94 / 0.4)",
    fill_glass: "rgb(0 0 0 / 0.6)",
    border_glass: "rgb(34 197 94 / 0.3)",
    shadow_color: "transparent",
    shadow_color_strong: "transparent",
    overlay_backdrop: "rgb(0 0 0 / 0.65)",
    overlay_backdrop_strong: "rgb(0 0 0 / 0.8)",
    highlight_primary:
      "color-mix(in oklab, #{css_const({:colors, :green_400})} 16%, transparent)",
    glow_primary: "color-mix(in oklab, #{css_const({:colors, :green_400})} 35%, transparent)",
    glow_secondary: "transparent",
    focus_ring: "color-mix(in oklab, #{css_const({:colors, :green_400})} 40%, transparent)",
    font_body: css_const({:font, :mono}),
    font_heading: css_const({:font, :mono}),
    radius_surface: css_const({:radius, :none}),
    radius_card: css_const({:radius, :none}),
    border_width: "1px",
    border_style: "solid",
    shadow_surface: "none",
    shadow_card: "none"
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
