defmodule LiveStyleDemoWeb.SharedStyles do
  @moduledoc false

  use LiveStyle

  class(:surface,
    background_color: "#f8fafc",
    border: "1px solid #dbe4f0"
  )

  class(:module_ref,
    background_color: "#1d4ed8",
    color: "#ffffff",
    border_radius: "9999px",
    padding: "0.25rem 0.75rem",
    font_size: "0.75rem",
    font_weight: "700"
  )

  class(:list_ref,
    border: "1px dashed #1d4ed8",
    color: "#1e3a8a"
  )

  class(:dynamic_opacity, fn opacity -> [opacity: opacity] end)
end
