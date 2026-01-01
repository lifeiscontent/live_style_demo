defmodule LiveStyleDemoWeb.Tokens.Semantic do
  @moduledoc """
  Semantic design tokens (themed colors, fonts).

  These are CSS custom properties that can be themed.
  """
  use LiveStyle

  # DEFAULT THEME: SWISS (Clean, Minimal, Grid-based)
  # Palette: White, Black, Red.

  vars(
    # Text
    text_primary: "#000000",
    text_secondary: "#555555",
    text_muted: "#999999",

    # Dedicated button text tokens for perfect contrast
    text_on_primary: "#ffffff",
    text_accent: "#ff3e00",
    text_link: "#ff3e00",

    # Fill/background
    fill_primary: "#ff3e00",
    # Swiss Hover: Black (High contrast)
    fill_primary_hover: "#000000",
    fill_secondary: "#e5e5e5",
    fill_danger: "#ff0000",
    # Minimalist success
    fill_success: "#000000",
    # Minimalist warning
    fill_warning: "#000000",
    fill_page: "#ffffff",
    fill_surface: "#f8f8f8",
    fill_muted: "#f2f2f2",

    # Border
    border_default: "#e5e5e5",
    border_subtle: "#f0f0f0",
    border_input: "#d1d5db",
    border_focus: "#000000",

    # Status / intent
    text_danger: "#ff0000",
    text_success: "#000000",

    # Effects / polish (Strict: No gradients)
    fill_glass: "#ffffff",
    border_glass: "#e5e5e5",
    shadow_color: "rgba(0,0,0,0.1)",
    shadow_color_strong: "rgba(0,0,0,0.2)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    highlight_primary: "#ff3e00",
    focus_ring: "#000000",

    # Themeable UI decisions
    font_body: "'Helvetica Neue', Helvetica, Arial, sans-serif",
    font_heading: "'Helvetica Neue', Helvetica, Arial, sans-serif"
  )

  # ===========================================================================
  # Themes
  # ===========================================================================

  # THEME: TERMINAL (Developer focused, High Contrast)
  # Palette: Black, Green, White.

  theme(:terminal,
    text_primary: "#00ff00",
    text_secondary: "#00aa00",
    text_muted: "#005500",
    text_on_primary: "#000000",
    text_accent: "#ffffff",
    text_link: "#00ff00",
    fill_primary: "#00ff00",
    # Terminal Hover: White (Max contrast with Black text)
    fill_primary_hover: "#ffffff",
    fill_secondary: "#002200",
    fill_danger: "#ff0000",
    fill_success: "#00ff00",
    fill_warning: "#ffff00",
    text_danger: "#ff0000",
    text_success: "#00ff00",
    fill_page: "#000000",
    fill_surface: "#001100",
    fill_muted: "#002200",
    border_default: "#004400",
    border_subtle: "#002200",
    border_input: "#004400",
    border_focus: "#00ff00",
    fill_glass: "#000000",
    border_glass: "#00ff00",
    shadow_color: "transparent",
    shadow_color_strong: "transparent",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#00ff00",
    highlight_primary: "#ffffff",
    font_body: "'Courier New', Courier, monospace",
    font_heading: "'Courier New', Courier, monospace"
  )

  # THEME: BLUEPRINT (Technical, Precise)
  # Palette: Blueprint Blue, White, Darker Blue.

  theme(:blueprint,
    text_primary: "#ffffff",
    text_secondary: "#a0c0ff",
    text_muted: "#5070a0",
    text_on_primary: "#002060",
    text_accent: "#ffffff",
    text_link: "#ffffff",
    fill_primary: "#ffffff",
    fill_primary_hover: "#e0e0e0",
    fill_secondary: "#004080",
    fill_danger: "#ff6666",
    fill_success: "#66ff66",
    fill_warning: "#ffff66",
    text_danger: "#ff6666",
    text_success: "#66ff66",
    # Blueprint Blue
    fill_page: "#003366",
    fill_surface: "#002b55",
    fill_muted: "#002040",

    # White lines
    border_default: "#ffffff",
    border_subtle: "#5070a0",
    border_input: "#ffffff",
    border_focus: "#ffffff",
    fill_glass: "#003366",
    border_glass: "#ffffff",
    shadow_color: "rgba(0,0,0,0.2)",
    shadow_color_strong: "rgba(0,0,0,0.4)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#ffffff",
    highlight_primary: "#ffffff",
    font_body: "'Consolas', 'Monaco', monospace",
    font_heading: "'Consolas', 'Monaco', monospace"

    # Blueprint style
  )

  # THEME: SOLAR (Warm, Light, Sophisticated)
  # Palette: Cream, Deep Teal, Magenta.

  theme(:solar,
    text_primary: "#002b36",
    text_secondary: "#586e75",
    text_muted: "#93a1a1",
    text_on_primary: "#fdf6e3",
    text_accent: "#d33682",
    text_link: "#d33682",
    fill_primary: "#d33682",
    # Solar Hover: Deep Teal (Base02)
    fill_primary_hover: "#073642",
    # Distinct from surface for the style guide palette.
    fill_secondary: "#e3dbbf",
    fill_danger: "#dc322f",
    fill_success: "#859900",
    fill_warning: "#b58900",
    text_danger: "#dc322f",
    text_success: "#859900",
    # Cream
    fill_page: "#fdf6e3",
    fill_surface: "#eee8d5",
    fill_muted: "#e3dbbf",
    border_default: "#93a1a1",
    border_subtle: "#e3dbbf",
    border_input: "#93a1a1",
    border_focus: "#d33682",
    fill_glass: "#fdf6e3",
    border_glass: "#93a1a1",
    shadow_color: "rgba(0,43,54,0.1)",
    shadow_color_strong: "rgba(0,43,54,0.2)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#d33682",
    highlight_primary: "#d33682",
    font_body: "'Gill Sans', 'Gill Sans MT', Calibri, sans-serif",
    font_heading: "'Gill Sans', 'Gill Sans MT', Calibri, sans-serif"
  )

  # THEME: NAVY (Dark, Deep, Cyber-lite)
  # Palette: Navy, Light Blue, Teal.

  theme(:navy,
    text_primary: "#e6f1ff",
    text_secondary: "#8892b0",
    text_muted: "#495670",
    text_on_primary: "#0a192f",
    text_accent: "#64ffda",
    text_link: "#64ffda",
    fill_primary: "#64ffda",
    # Navy Hover: White
    fill_primary_hover: "#ffffff",
    # Distinct from surface for the style guide palette.
    fill_secondary: "#233554",
    fill_danger: "#ff5f5f",
    fill_success: "#64ffda",
    fill_warning: "#ffbd2e",
    text_danger: "#ff5f5f",
    text_success: "#64ffda",
    # Navy
    fill_page: "#0a192f",
    fill_surface: "#112240",
    fill_muted: "#020c1b",
    border_default: "#233554",
    border_subtle: "#1d2d44",
    border_input: "#233554",
    border_focus: "#64ffda",
    fill_glass: "#112240",
    border_glass: "#233554",
    shadow_color: "rgba(2,12,27,0.7)",
    shadow_color_strong: "rgba(2,12,27,0.9)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#64ffda",
    highlight_primary: "#64ffda",
    font_body: "'Fira Code', monospace",
    font_heading: "'Fira Code', monospace"
  )

  # THEME: FOREST (Organic, Calm, Dark)
  # Palette: Deep Green, Off-White, Gold.

  theme(:forest,
    text_primary: "#ecfdf5",
    text_secondary: "#a7f3d0",
    text_muted: "#6ee7b7",
    text_on_primary: "#022c22",
    text_accent: "#fbbf24",
    text_link: "#fbbf24",
    fill_primary: "#fbbf24",
    # Forest Hover: Off-White
    fill_primary_hover: "#ecfdf5",
    # Distinct from surface for the style guide palette.
    fill_secondary: "#065f46",
    fill_danger: "#f87171",
    fill_success: "#fbbf24",
    fill_warning: "#fbbf24",
    text_danger: "#f87171",
    text_success: "#fbbf24",
    # Deep Green
    fill_page: "#022c22",
    # Surface Green
    fill_surface: "#064e3b",
    fill_muted: "#065f46",
    border_default: "#065f46",
    border_subtle: "#064e3b",
    border_input: "#065f46",
    border_focus: "#fbbf24",
    fill_glass: "#064e3b",
    border_glass: "#065f46",
    shadow_color: "rgba(0,0,0,0.3)",
    shadow_color_strong: "rgba(0,0,0,0.5)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#fbbf24",
    highlight_primary: "#fbbf24",
    font_body: "'Georgia', serif",
    font_heading: "'Georgia', serif"
  )

  # THEME: LAVENDER (Soft, Playful, Light)
  # Palette: White, Purple, Violet.

  theme(:lavender,
    text_primary: "#4c1d95",
    text_secondary: "#6d28d9",
    text_muted: "#8b5cf6",
    text_on_primary: "#ffffff",
    text_accent: "#7c3aed",
    text_link: "#7c3aed",
    fill_primary: "#8b5cf6",
    # Lavender Hover: Deep Purple
    fill_primary_hover: "#5b21b6",
    # Distinct from surface for the style guide palette.
    fill_secondary: "#ddd6fe",
    fill_danger: "#db2777",
    fill_success: "#8b5cf6",
    fill_warning: "#8b5cf6",
    text_danger: "#db2777",
    text_success: "#8b5cf6",
    fill_page: "#ffffff",
    fill_surface: "#f5f3ff",
    fill_muted: "#ede9fe",
    border_default: "#ddd6fe",
    border_subtle: "#ede9fe",
    border_input: "#c4b5fd",
    border_focus: "#8b5cf6",
    fill_glass: "#ffffff",
    border_glass: "#ddd6fe",
    shadow_color: "rgba(139, 92, 246, 0.15)",
    shadow_color_strong: "rgba(139, 92, 246, 0.25)",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#8b5cf6",
    highlight_primary: "#7c3aed",
    # Playful font
    font_body: "'Comic Sans MS', 'Chalkboard SE', sans-serif",
    font_heading: "'Comic Sans MS', 'Chalkboard SE', sans-serif"
  )

  # THEME: BRUTAL (Raw, Bold, High Contrast)
  # Palette: Silver, Black, Blue.

  theme(:brutal,
    text_primary: "#000000",
    text_secondary: "#333333",
    text_muted: "#666666",
    text_on_primary: "#ffffff",
    text_accent: "#2563eb",
    text_link: "#2563eb",
    fill_primary: "#2563eb",
    # Brutal Hover: Black (High contrast)
    fill_primary_hover: "#000000",
    # Distinct from surface for the style guide palette.
    fill_secondary: "#e5e7eb",
    fill_danger: "#ef4444",
    fill_success: "#2563eb",
    fill_warning: "#2563eb",
    text_danger: "#ef4444",
    text_success: "#2563eb",
    fill_page: "#e5e7eb",
    fill_surface: "#ffffff",
    fill_muted: "#d1d5db",
    border_default: "#000000",
    border_subtle: "#000000",
    border_input: "#000000",
    border_focus: "#2563eb",
    fill_glass: "#ffffff",
    border_glass: "#000000",
    shadow_color: "#000000",
    shadow_color_strong: "#000000",
    overlay_backdrop: "rgba(0,0,0,0.4)",
    focus_ring: "#2563eb",
    highlight_primary: "#2563eb",
    font_body: "'Courier New', Courier, monospace",
    font_heading: "'Impact', 'Arial Black', sans-serif"
  )
end
