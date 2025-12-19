defmodule LiveStyleDemoWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use LiveStyleDemoWeb, :html

  # Ensure Tokens is compiled first
  require LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens

  embed_templates("page_html/*")

  # Page styles
  css_rule(:page_container,
    min_height: "100vh",
    display: "flex",
    align_items: "center",
    justify_content: "center",
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    padding: css_var({Tokens, :space, :"8"}),
    font_family: css_var({Tokens, :font, :sans}),
    "-webkit-font-smoothing": "antialiased",
    "-moz-osx-font-smoothing": "grayscale"
  )

  css_rule(:content_wrapper,
    max_width: "48rem",
    text_align: "center",
    position: "sticky"
  )

  css_rule(:title,
    font_size: css_var({Tokens, :font_size, :"3xl"}),
    font_weight: css_var({Tokens, :font_weight, :bold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_rule(:subtitle,
    font_size: css_var({Tokens, :font_size, :lg}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    margin_bottom: css_var({Tokens, :space, :"8"})
  )

  css_rule(:features,
    display: "grid",
    gap: css_var({Tokens, :space, :"6"}),
    margin_bottom: css_var({Tokens, :space, :"8"}),
    grid_template_columns: "1fr"
  )

  css_rule(:feature_card,
    background_color: css_var({Tokens, :semantic, :fill_page}),
    padding: css_var({Tokens, :space, :"6"}),
    border_radius: css_var({Tokens, :radius, :lg}),
    box_shadow: css_var({Tokens, :shadow, :default}),
    text_align: "left"
  )

  css_rule(:feature_title,
    font_size: css_var({Tokens, :font_size, :lg}),
    font_weight: css_var({Tokens, :font_weight, :semibold}),
    color: css_var({Tokens, :semantic, :text_primary}),
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_rule(:feature_text,
    font_size: css_var({Tokens, :font_size, :base}),
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_var({Tokens, :leading, :relaxed})
  )

  css_rule(:buttons,
    display: "flex",
    gap: css_var({Tokens, :space, :"4"}),
    justify_content: "center"
  )

  css_rule(:btn_primary,
    display: "inline-flex",
    align_items: "center",
    padding_top: css_var({Tokens, :space, :"3"}),
    padding_bottom: css_var({Tokens, :space, :"3"}),
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"}),
    background_color: css_var({Tokens, :semantic, :fill_primary}),
    color: css_var({Tokens, :semantic, :text_inverse}),
    font_weight: css_var({Tokens, :font_weight, :medium}),
    border_radius: css_var({Tokens, :radius, :md}),
    text_decoration: "none",
    transition: "background-color 0.2s ease"
  )

  css_rule(:btn_secondary,
    display: "inline-flex",
    align_items: "center",
    padding_top: css_var({Tokens, :space, :"3"}),
    padding_bottom: css_var({Tokens, :space, :"3"}),
    padding_left: css_var({Tokens, :space, :"6"}),
    padding_right: css_var({Tokens, :space, :"6"}),
    background_color: css_var({Tokens, :semantic, :fill_secondary}),
    color: css_var({Tokens, :semantic, :text_primary}),
    font_weight: css_var({Tokens, :font_weight, :medium}),
    border_radius: css_var({Tokens, :radius, :md}),
    text_decoration: "none",
    transition: "background-color 0.2s ease"
  )
end
