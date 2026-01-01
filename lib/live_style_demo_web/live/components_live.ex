defmodule LiveStyleDemoWeb.ComponentsLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens
  alias LiveStyleDemoWeb.Tokens.Semantic
  alias LiveStyleDemoWeb.Tokens.Space

  class(:grid,
    display: "grid",
    gap: var({Space, :"8"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(420px, 100%), 1fr))"
  )

  class(:title,
    font_size: const({Tokens, :font_size_xl}),
    font_weight: const({Tokens, :font_weight_bold}),
    letter_spacing: "-0.02em",
    line_height: const({Tokens, :leading_tight})
  )

  class(:text,
    color: var({Semantic, :text_secondary}),
    line_height: const({Tokens, :leading_relaxed})
  )

  class(:code,
    background_color: var({Semantic, :fill_surface}),
    border: "1px solid #{var({Semantic, :border_subtle})}",
    border_radius: const({Tokens, :radius_xl}),
    padding: var({Space, :"4"}),
    overflow_x: "auto"
  )

  class(:pre,
    margin: "0",
    font_family: const({Tokens, :font_mono}),
    font_size: const({Tokens, :font_size_sm}),
    line_height: const({Tokens, :leading_relaxed}),
    white_space: "pre",
    color: var({Semantic, :text_secondary})
  )

  class(:card_body,
    padding: var({Space, :"6"}),
    display: "grid",
    gap: var({Space, :"4"})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Components")}
  end

  defp tailwind_example do
    """
    <button
      class=\"inline-flex items-center justify-center gap-2 rounded-lg px-6 py-3\
             text-sm font-medium text-white shadow-lg shadow-indigo-500/20\
             bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2\
             focus:ring-indigo-400 focus:ring-offset-2\"
    >
      Create
    </button>
    """
  end

  defp livestyle_example do
    """
    # styles live in Elixir
    class :btn_base, ...
    class :btn_primary, ...

    # markup stays calm
    <button {css([:btn_base, :btn_primary])}>
      Create
    </button>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="components"
      show_footer
      page_title="Components"
      page_subtitle="Atomic output without turning templates into class strings."
    >
      <div {css(:grid)}>
        <.card as={:section}>
          <div {css(:card_body)}>
            <h2 {css(:title)}>Utility markup (typical)</h2>
            <p {css(:text)}>
              Utility classes are fast early on, but they spread design decisions across markup.
              Later refactors (spacing, typography, semantics) become a search-and-rewrite problem.
            </p>
            <div {css(:code)}>
              <pre {css(:pre)}>{tailwind_example()}</pre>
            </div>
          </div>
        </.card>

        <.card as={:section}>
          <div {css(:card_body)}>
            <h2 {css(:title)}>LiveStyle markup (clean)</h2>
            <p {css(:text)}>
              Styles live in Elixir modules, compile to atomic CSS, and get reused like any other code.
              Your templates describe structure, not implementation details.
            </p>
            <div {css(:code)}>
              <pre {css(:pre)}>{livestyle_example()}</pre>
            </div>
          </div>
        </.card>
      </div>
    </.shell>
    """
  end
end
