defmodule LiveStyleDemoWeb.Tokens.Anim do
  @moduledoc """
  Animation design tokens (CSS custom properties for animations).
  """
  use LiveStyle
  import LiveStyle.TypedProperty

  vars(
    angle: angle("0deg"),
    hue: angle("260deg"),
    chroma: number(0.22)
  )
end
