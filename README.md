# LiveStyle Demo

A demonstration application showcasing [LiveStyle](https://github.com/lifeiscontent/live_style) - an atomic CSS-in-Elixir library for Phoenix LiveView, inspired by Meta's StyleX.

## Features Demonstrated

### Design Tokens

Centralized design system with semantic tokens for colors, spacing, typography, and more:

```elixir
defvars(:color, %{
  gray_500: "#6b7280",
  indigo_600: "#4f46e5"
})

defvars(:text, %{
  primary: var(:color_gray_900),
  accent: var(:color_indigo_600)
})
```

### Atomic CSS Generation

Zero-runtime CSS with compile-time extraction:

```elixir
props(%{
  display: "flex",
  gap: var(:space_4),
  padding: var(:space_6),
  background_color: var(:fill_card),
  border_radius: var(:radius_lg)
})
```

### View Transitions API

Smooth animations for LiveView DOM updates with the View Transitions API:

```elixir
defkeyframes(:vt_scale_in, %{
  from: %{opacity: "0", transform: "scale(0.8)"},
  to: %{opacity: "1", transform: "scale(1)"}
})

view_transition("todo-*", %{
  old_only_child: %{
    animation_name: %{
      :default => :vt_scale_out,
      "@media (prefers-reduced-motion: reduce)" => "none"
    },
    animation_duration: "250ms"
  },
  new_only_child: %{
    animation_name: :vt_scale_in,
    animation_duration: "250ms"
  }
})
```

### Theming

Runtime theme switching with CSS custom properties:

```elixir
create_theme(:dark_fill, :fill, %{
  page: "#030712",
  surface: "#111827",
  card: "#1f2937"
})
```

## Demo Pages

- **Home** (`/`) - Animated gradient hero with design token showcase
- **Todo App** (`/todos`) - View Transitions API demo with add/remove/reorder animations
- **Data Table** (`/table`) - Interactive table with hover effects and sorting

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
  use LiveStyle.ViewTransitions

  defvars(:color, %{...})
  defvars(:space, %{...})
  defkeyframes(:spin, %{...})
  view_transition("todo-*", %{...})
end
```

### 2. Use in Components

Reference tokens in your LiveView components:

```elixir
def render(assigns) do
  ~H"""
  <div class={props(%{
    padding: var(:space_4),
    color: var(:text_primary),
    background: var(:fill_card)
  })}>
    Content here
  </div>
  """
end
```

### 3. View Transitions

For animated DOM updates, add `view-transition-name` to elements:

```elixir
<div
  class={props(%{view_transition_name: "todo-#{todo.id}"})}
  id={"todo-#{todo.id}"}
>
  {todo.title}
</div>
```

The CSS for transitions is generated from `view_transition/2` definitions.

## Related

- [LiveStyle](https://github.com/lifeiscontent/live_style) - The main library
- [StyleX](https://stylexjs.com/) - Meta's CSS-in-JS library (inspiration)
- [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view) - Real-time server-rendered HTML

## License

MIT License - see [LICENSE](LICENSE) for details.
