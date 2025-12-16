defmodule LiveStyleDemoWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use LiveStyleDemoWeb, :html
  use LiveStyle

  embed_templates("page_html/*")

  # Page styles
  style(:page_container, %{
    min_height: "100vh",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    background_color: var(:fill_muted),
    padding: var(:space_8),
    font_family: var(:font_sans),
    "-webkit-font-smoothing": "antialiased",
    "-moz-osx-font-smoothing": "grayscale"
  })

  style(:content_wrapper, %{
    max_width: "48rem",
    text_align: "center",
    # Demonstrate first_that_works for sticky positioning fallback
    position: first_that_works(["sticky", "-webkit-sticky", "relative"])
  })

  style(:title, %{
    font_size: var(:text_size_3xl),
    font_weight: var(:font_weight_bold),
    color: var(:text_primary),
    margin_bottom: var(:space_2)
  })

  style(:subtitle, %{
    font_size: var(:text_size_lg),
    color: var(:text_secondary),
    margin_bottom: var(:space_8)
  })

  style(:features,
    display: "grid",
    gap: var(:space_6),
    margin_bottom: var(:space_8),
    grid_template_columns: [
      {:default, "1fr"},
      {LiveStyleDemoWeb.Tokens.breakpoints_md(), "repeat(2, 1fr)"},
      {LiveStyleDemoWeb.Tokens.breakpoints_lg(), "repeat(3, 1fr)"}
    ]
  )

  style(:feature_card, %{
    background_color: var(:fill_page),
    padding: var(:space_6),
    border_radius: var(:radius_lg),
    box_shadow: var(:shadow_default),
    text_align: "left"
  })

  style(:feature_title, %{
    font_size: var(:text_size_lg),
    font_weight: var(:font_weight_semibold),
    color: var(:text_primary),
    margin_bottom: var(:space_2)
  })

  style(:feature_text, %{
    font_size: var(:text_size_base),
    color: var(:text_secondary),
    line_height: var(:leading_relaxed)
  })

  style(:buttons, %{
    display: "flex",
    gap: var(:space_4),
    justify_content: "center"
  })

  style(:btn_primary, %{
    display: "inline-flex",
    align_items: "center",
    padding_top: var(:space_3),
    padding_bottom: var(:space_3),
    padding_left: var(:space_6),
    padding_right: var(:space_6),
    background_color: %{
      default: var(:fill_primary),
      ":hover": var(:fill_primary_hover)
    },
    color: var(:text_inverse),
    font_weight: var(:font_weight_medium),
    border_radius: var(:radius_md),
    text_decoration: "none"
  })

  style(:btn_secondary, %{
    display: "inline-flex",
    align_items: "center",
    padding_top: var(:space_3),
    padding_bottom: var(:space_3),
    padding_left: var(:space_6),
    padding_right: var(:space_6),
    background_color: %{
      default: var(:fill_secondary),
      ":hover": var(:fill_secondary_hover)
    },
    color: var(:text_primary),
    font_weight: var(:font_weight_medium),
    border_radius: var(:radius_md),
    text_decoration: "none"
  })
end
