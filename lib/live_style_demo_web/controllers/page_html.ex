defmodule LiveStyleDemoWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use LiveStyleDemoWeb, :html
  use LiveStyle

  class(:interop_page,
    min_height: "100vh",
    display: "grid",
    place_items: "center",
    background: "linear-gradient(140deg, #eef4ff 0%, #f8fafc 50%, #f5fbff 100%)",
    padding: "2rem"
  )

  class(:interop_card,
    width: "min(860px, 100%)",
    border_radius: "20px",
    box_shadow: "0 18px 45px rgba(15, 23, 42, 0.1)",
    padding: "2rem"
  )

  class(:title,
    margin_bottom: "0.75rem",
    font_size: "2rem",
    font_weight: "800",
    line_height: "1.15",
    color: "#0f172a"
  )

  class(:subtitle,
    margin_bottom: "1rem",
    color: "#334155",
    line_height: "1.6"
  )

  class(:row,
    display: "flex",
    gap: "0.75rem",
    flex_wrap: "wrap",
    margin_bottom: "1rem"
  )

  class(:chip_local,
    background_color: "#dbeafe",
    color: "#1e3a8a",
    border_radius: "9999px",
    padding: "0.25rem 0.75rem",
    font_size: "0.75rem",
    font_weight: "700"
  )

  class(:code,
    border_radius: "12px",
    padding: "1rem",
    background_color: "#0f172a",
    color: "#e2e8f0",
    font_size: "0.85rem",
    line_height: "1.6",
    overflow_x: "auto"
  )

  class(:dynamic_opacity, fn opacity -> [opacity: opacity] end)

  embed_templates "page_html/*"
end
