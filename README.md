# LiveStyle Demo

A demonstration application showcasing [LiveStyle](https://github.com/lifeiscontent/live_style) - an atomic CSS-in-Elixir library for Phoenix LiveView, inspired by Meta's StyleX.

## Features Demonstrated

### Design Tokens

Centralized design system with semantic tokens for colors, spacing, typography, and more:

```elixir
# Define raw color palette
css_vars(:colors,
  gray_500: "#6b7280",
  indigo_600: "#4f46e5"
)

# Define semantic tokens that reference colors
css_vars(:semantic,
  text_primary: css_var({:colors, :gray_900}),
  text_accent: css_var({:colors, :indigo_600})
)
```

### Atomic CSS Generation

Zero-runtime CSS with compile-time extraction:

```elixir
css_class(:card,
  display: "flex",
  gap: css_const({Tokens, :space, :"4"}),
  padding: css_const({Tokens, :space, :"6"}),
  background_color: css_var({Tokens, :semantic, :fill_card}),
  border_radius: css_const({Tokens, :radius, :lg})
)
```

### View Transitions API

Smooth animations for LiveView DOM updates with the View Transitions API:

```elixir
css_keyframes(:vt_scale_in,
  from: [opacity: "0", transform: "scale(0.8)"],
  to: [opacity: "1", transform: "scale(1)"]
)

css_view_transition(:todo_transition,
  old: [
    animation_name: css_keyframes(:vt_scale_out),
    animation_duration: "250ms",
    animation_timing_function: "ease-out"
  ],
  new: [
    animation_name: css_keyframes(:vt_scale_in),
    animation_duration: "250ms",
    animation_timing_function: "ease-out"
  ]
)
```

### Theming

Runtime theme switching with CSS custom properties:

```elixir
css_theme(:semantic, :dark,
  text_primary: css_var({:colors, :gray_50}),
  fill_page: css_var({:colors, :gray_950}),
  fill_surface: css_var({:colors, :gray_900})
)
```

## Demo Pages

- **Home** (`/`) - Animated gradient hero with design token showcase
- **Todo App** (`/todo`) - View Transitions API demo with add/remove/reorder animations
- **Data Table** (`/table`) - Interactive table with cross-highlight effects using When selectors

## Getting Started

### Prerequisites

- Elixir 1.15+
- Erlang/OTP 26+
- Node.js 18+ (for asset building)

### Setup

```bash
# Clone the repository
git clone https://github.com/lifeiscontent/live_style_demo.git
cd live_style_demo

# Install dependencies
mix setup

# Start the Phoenix server
mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) in your browser.

## Project Structure

```
lib/
├── live_style_demo_web/
│   ├── tokens.ex           # Design tokens & view transitions
│   ├── live/
│   │   ├── home_live.ex    # Homepage with gradient animation
│   │   ├── todo_live.ex    # Todo app with view transitions
│   │   └── table_live.ex   # Data table demo
│   └── components/
│       └── layouts.ex      # App layout components
```

## How It Works

### 1. Define Tokens

Design tokens are defined in `tokens.ex` using LiveStyle macros:

```elixir
defmodule LiveStyleDemoWeb.Tokens do
  use LiveStyle.Tokens

  css_vars(:colors, gray_500: "#6b7280", ...)
  css_vars(:semantic, text_primary: css_var({:colors, :gray_900}), ...)
  css_consts(:space, "4": "1rem", ...)
  css_keyframes(:spin, from: [...], to: [...])
  css_view_transition(:todo_transition, old: [...], new: [...])
end
```

### 2. Use in Components

Reference tokens in your LiveView components:

```elixir
css_class(:card,
  padding: css_const({Tokens, :space, :"4"}),
  color: css_var({Tokens, :semantic, :text_primary}),
  background: css_var({Tokens, :semantic, :fill_card})
)

def render(assigns) do
  ~H"""
  <div class={css_class([:card])}>
    Content here
  </div>
  """
end
```

### 3. View Transitions

For animated DOM updates, apply the view transition class to elements:

```elixir
<div
  class={css_view_transition({Tokens, :todo_transition})}
  style={"view-transition-name: todo-#{todo.id}"}
  id={"todo-#{todo.id}"}
>
  {todo.title}
</div>
```

The CSS for transitions is generated from `css_view_transition/2` definitions.

## Related

- [LiveStyle](https://github.com/lifeiscontent/live_style) - The main library
- [StyleX](https://stylexjs.com/) - Meta's CSS-in-JS library (inspiration)
- [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view) - Real-time server-rendered HTML

## License

MIT License - see [LICENSE](LICENSE) for details.
