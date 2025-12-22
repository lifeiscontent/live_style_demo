defmodule LiveStyleDemoWeb.CleanHeexLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens

  alias LiveStyleDemoWeb.Tokens

  css_class(:grid,
    display: "grid",
    gap: css_var({Tokens, :space, :"6"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(420px, 100%), 1fr))"
  )

  css_class(:panel,
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(12px) saturate(1.1)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :"2xl"}),
    padding: css_var({Tokens, :space, :"6"}),
    display: "grid",
    gap: css_var({Tokens, :space, :"4"}),
    min_width: "0"
  )

  css_class(:title,
    font_size: css_const({Tokens, :font_size, :xl}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    line_height: css_const({Tokens, :leading, :tight})
  )

  css_class(:text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed})
  )

  css_class(:code,
    background_color: css_var({Tokens, :semantic, :fill_surface}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_subtle})}",
    border_radius: css_const({Tokens, :radius, :xl}),
    padding: css_var({Tokens, :space, :"4"}),
    overflow_x: "auto"
  )

  css_class(:pre,
    margin: "0",
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    white_space: "pre",
    color: css_var({Tokens, :semantic, :text_secondary})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Clean HEEx")}
  end

  defp tailwind_example do
    """
    <button
      class=\"inline-flex items-center justify-center gap-2 rounded-lg px-6 py-3\
             text-sm font-medium text-white shadow-lg shadow-indigo-500/20\
             bg-gradient-to-br from-indigo-500 via-violet-500 to-pink-500\
             hover:brightness-110 focus:outline-none focus:ring-2\
             focus:ring-indigo-400 focus:ring-offset-2\"
    >
      Create
    </button>
    """
  end

  defp livestyle_example do
    """
    # styles live in Elixir
    css_class :btn_base, ...
    css_class :btn_primary, ...

    # markup stays calm
    <button class={css_class([:btn_base, :btn_primary])}>
      Create
    </button>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="clean-heex"
      show_footer
      page_title="Clean HEEx"
      page_subtitle="Atomic output without turning templates into class strings."
    >
      <div class={css_class([:grid])}>
        <section class={css_class([:panel])}>
          <h2 class={css_class([:title])}>Utility markup (typical)</h2>
          <p class={css_class([:text])}>
            Utility classes are fast early on, but they spread design decisions across markup.
            Later refactors (spacing, typography, semantics) become a search-and-rewrite problem.
          </p>
          <div class={css_class([:code])}>
            <pre class={css_class([:pre])}>{tailwind_example()}</pre>
          </div>
        </section>

        <section class={css_class([:panel])}>
          <h2 class={css_class([:title])}>LiveStyle markup (clean)</h2>
          <p class={css_class([:text])}>
            Styles live in Elixir modules, compile to atomic CSS, and get reused like any other code.
            Your templates describe structure, not implementation details.
          </p>
          <div class={css_class([:code])}>
            <pre class={css_class([:pre])}>{livestyle_example()}</pre>
          </div>
        </section>
      </div>
    </.shell>
    """
  end
end
