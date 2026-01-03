defmodule LiveStyleDemoWeb.Tokens.Space do
  @moduledoc """
  Spacing design tokens (themed spacing scale).

  These are CSS custom properties that can be themed for
  compact or cozy layouts.
  """
  use LiveStyle

  vars(
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

  theme_class(:compact,
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

  theme_class(:cozy,
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
end
