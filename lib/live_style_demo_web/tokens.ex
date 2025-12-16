defmodule LiveStyleDemoWeb.Tokens do
  @moduledoc """
  Design tokens for the LiveStyle demo application.

  ## Naming Convention

  The `var()` macro splits atom names on the first underscore to determine
  namespace and name. For example:
  - `var(:color_blue_500)` -> namespace: "color", name: "blue_500"
  - `var(:text_primary)` -> namespace: "text", name: "primary"
  - `var(:text_size_lg)` -> namespace: "text", name: "size_lg"

  So when defining tokens with `defvars(:namespace, %{name: value})`, the
  namespace + name must match what's expected by `var(:namespace_name)`.
  """
  use LiveStyle.Tokens
  use LiveStyle.ViewTransitions
  import LiveStyle.Types

  # Colors - Base palette
  defvars(:color, %{
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
  })

  # Semantic text colors + text sizes
  # var(:text_primary) -> "text:primary"
  # var(:text_size_lg) -> "text:size_lg"
  defvars(:text, %{
    # Colors
    primary: var(:color_gray_900),
    secondary: var(:color_gray_600),
    muted: var(:color_gray_400),
    inverse: var(:color_white),
    accent: var(:color_indigo_600),
    link: var(:color_blue_600),
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
  })

  defvars(:fill, %{
    primary: var(:color_indigo_600),
    primary_hover: var(:color_indigo_500),
    secondary: var(:color_gray_100),
    secondary_hover: var(:color_gray_200),
    accent: var(:color_purple_500),
    danger: var(:color_red_600),
    success: var(:color_green_600),
    warning: var(:color_amber_500),
    page: var(:color_white),
    surface: var(:color_gray_50),
    muted: var(:color_gray_100),
    card: var(:color_white)
  })

  defvars(:border, %{
    default: var(:color_gray_200),
    subtle: var(:color_gray_100),
    focus: var(:color_indigo_500),
    accent: var(:color_indigo_200)
  })

  # Spacing
  defvars(:space, %{
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
  })

  # Typography - font families and weights
  # var(:font_sans) -> "font:sans"
  # var(:font_weight_bold) -> "font:weight_bold"
  defvars(:font, %{
    sans: "'Inter', system-ui, -apple-system, sans-serif",
    mono: "ui-monospace, monospace",
    weight_normal: "400",
    weight_medium: "500",
    weight_semibold: "600",
    weight_bold: "700"
  })

  defvars(:leading, %{
    none: "1",
    tight: "1.25",
    normal: "1.5",
    relaxed: "1.75"
  })

  # Border radius
  defvars(:radius, %{
    none: "0",
    sm: "0.125rem",
    default: "0.25rem",
    md: "0.375rem",
    lg: "0.5rem",
    xl: "0.75rem",
    "2xl": "1rem",
    "3xl": "1.5rem",
    full: "9999px"
  })

  # Shadows
  defvars(:shadow, %{
    sm: "0 1px 2px 0 rgb(0 0 0 / 0.05)",
    default: "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)",
    md: "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
    lg: "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
  })

  # Animation - typed variables for CSS animations
  # Using angle() type allows animating the gradient rotation
  defvars(:anim, %{
    angle: angle("0deg")
  })

  # Keyframes
  defkeyframes(:spin, %{
    from: %{transform: "rotate(0deg)"},
    to: %{transform: "rotate(360deg)"}
  })

  defkeyframes(:pulse, %{
    "0%, 100%": %{opacity: "1"},
    "50%": %{opacity: "0.5"}
  })

  # Static constants (inlined at build time, not CSS variables)
  defconsts(:breakpoints, %{
    sm: "@media (max-width: 640px)",
    md: "@media (min-width: 641px) and (max-width: 1024px)",
    lg: "@media (min-width: 1025px)"
  })

  defconsts(:z, %{
    dropdown: "10",
    sticky: "20",
    fixed: "30",
    modal_backdrop: "40",
    modal: "50",
    popover: "60",
    tooltip: "70"
  })

  # Themes - override variable values for subtrees
  create_theme(:dark_fill, :fill, %{
    primary: "#818cf8",
    primary_hover: "#a5b4fc",
    secondary: "#374151",
    secondary_hover: "#4b5563",
    accent: "#c084fc",
    page: "#030712",
    surface: "#111827",
    muted: "#1f2937",
    card: "#1f2937"
  })

  create_theme(:dark_text, :text, %{
    primary: "#f9fafb",
    secondary: "#d1d5db",
    muted: "#6b7280",
    accent: "#a5b4fc",
    link: "#60a5fa"
  })

  create_theme(:dark_border, :border, %{
    default: "#374151",
    subtle: "#1f2937",
    focus: "#818cf8",
    accent: "#4f46e5"
  })

  # ============================================================================
  # View Transitions
  # ============================================================================

  # Keyframes for view transitions
  # defkeyframes creates a function that returns the hashed keyframe name
  defkeyframes(:vt_scale_in, %{
    from: %{opacity: "0", transform: "scale(0.8)"},
    to: %{opacity: "1", transform: "scale(1)"}
  })

  defkeyframes(:vt_scale_out, %{
    from: %{opacity: "1", transform: "scale(1)"},
    to: %{opacity: "0", transform: "scale(0.8)"}
  })

  defkeyframes(:vt_fade_in, %{
    from: %{opacity: "0"},
    to: %{opacity: "1"}
  })

  defkeyframes(:vt_fade_out, %{
    from: %{opacity: "1"},
    to: %{opacity: "0"}
  })

  # Todo items: scale for add/remove, fade for reorder
  # Respects prefers-reduced-motion
  #
  # Note: For animation-name, use atom references like :vt_scale_out
  # They get resolved to the hashed keyframe name at compile time
  view_transition("todo-*", %{
    old_only_child: %{
      animation_name: %{
        :default => :vt_scale_out,
        "@media (prefers-reduced-motion: reduce)" => "none"
      },
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    },
    new_only_child: %{
      animation_name: %{
        :default => :vt_scale_in,
        "@media (prefers-reduced-motion: reduce)" => "none"
      },
      animation_duration: "250ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    },
    old: %{
      animation_name: %{
        :default => :vt_fade_out,
        "@media (prefers-reduced-motion: reduce)" => "none"
      },
      animation_duration: "150ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    },
    new: %{
      animation_name: %{
        :default => :vt_fade_in,
        "@media (prefers-reduced-motion: reduce)" => "none"
      },
      animation_duration: "150ms",
      animation_delay: "50ms",
      animation_timing_function: "ease-out",
      animation_fill_mode: "both"
    }
  })
end
