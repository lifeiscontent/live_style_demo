# LiveStyle Demo

A demonstration application showcasing [LiveStyle](https://github.com/lifeiscontent/live_style) - an atomic CSS-in-Elixir library for Phoenix LiveView, inspired by Meta's StyleX.

## Features Demonstrated

### Design Tokens

Centralized design system with semantic tokens for colors, spacing, typography, and more:

```elixir
defmodule MyApp.Tokens do
  use LiveStyle

  # Define raw color palette
  vars(
    gray_500: "#6b7280",
    indigo_600: "#4f46e5"
  )
end

defmodule MyApp.Tokens.Semantic do
  use LiveStyle

  alias MyApp.Tokens

  # Define semantic tokens that reference colors
  vars(
    text_primary: var({Tokens, :gray_900}),
    text_accent: var({Tokens, :indigo_600})
  )
end
```

### Atomic CSS Generation

Zero-runtime CSS with compile-time extraction:

```elixir
defmodule MyAppWeb.CardLive do
  use MyAppWeb, :live_view

  alias MyApp.Tokens
  alias MyApp.Tokens.Semantic
  alias MyApp.Tokens.Space

  class(:card,
    display: "flex",
    gap: var({Space, :"4"}),
    padding: var({Space, :"6"}),
    background_color: var({Semantic, :fill_card}),
    border_radius: const({Tokens, :radius_lg})
  )

  def render(assigns) do
    ~H"""
    <div {css(:card)}>
      Content here
    </div>
    """
  end
end
```

### View Transitions API

Smooth animations for LiveView DOM updates with the View Transitions API:

```elixir
keyframes(:vt_scale_in,
  from: [opacity: "0", transform: "scale(0.8)"],
  to: [opacity: "1", transform: "scale(1)"]
)

view_transition(:todo_transition,
  old: [
    animation_name: keyframes(:vt_scale_out),
    animation_duration: "250ms",
    animation_timing_function: "ease-out"
  ],
  new: [
    animation_name: keyframes(:vt_scale_in),
    animation_duration: "250ms",
    animation_timing_function: "ease-out"
  ]
)
```

### Theming

Runtime theme switching with CSS custom properties:

```elixir
defmodule MyApp.Tokens.Semantic do
  use LiveStyle

  alias MyApp.Tokens

  vars(
    text_primary: var({Tokens, :gray_900}),
    fill_page: var({Tokens, :white}),
    fill_surface: var({Tokens, :gray_50})
  )

  theme(:dark,
    text_primary: var({Tokens, :gray_50}),
    fill_page: var({Tokens, :gray_950}),
    fill_surface: var({Tokens, :gray_900})
  )
end
```

## Demo Pages

- **Home** (`/`) - Animated gradient hero with design token showcase
- **Components** (`/components`) - Comparison of utility vs LiveStyle markup
- **Style Guide** (`/style-guide`) - Reference for all base components
- **Focus Card** (`/focus-card`) - Interactive card with hover/focus effects
- **Table** (`/table`) - Interactive table with cross-highlight effects using When selectors
- **Transitions** (`/transitions`) - View Transitions API demonstrations
- **Starting Style** (`/starting-style`) - CSS @starting-style animations
- **Scroll** (`/scroll`) - Scroll-driven animations
- **Container** (`/container`) - Container queries demo
- **Theming** (`/theming`) - Runtime theme switching
- **Colors** (`/colors`) - Color palette showcase
- **Popover** (`/popover`) - Popover and anchor positioning
- **Parent Selector** (`/parent-selector`) - CSS :has() selector demos
- **Todo App** (`/todo`) - View Transitions API demo with add/remove animations

## Getting Started

### Prerequisites

- Elixir 1.15+
- Erlang/OTP 26+

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
│   ├── tokens.ex           # Design tokens, animations & view transitions
│   ├── live/
│   │   ├── home_live.ex    # Homepage with gradient animation
│   │   ├── todo_live.ex    # Todo app with view transitions
│   │   ├── table_live.ex   # Data table with cross-highlighting
│   │   └── ...             # Other demo pages
│   └── components/
│       ├── ui_components.ex    # Buttons, inputs, badges, etc.
│       ├── shell_components.ex # Layout shell and navigation
│       └── layout_components.ex # Typography and layout primitives
```

## How It Works

### 1. Define Tokens

Design tokens are defined using LiveStyle macros. Each module becomes a namespace:

```elixir
defmodule LiveStyleDemoWeb.Tokens do
  use LiveStyle

  # Constants (static values, inlined at compile time)
  consts(
    font_size_sm: "0.875rem",
    font_size_base: "1rem",
    radius_lg: "0.5rem"
  )

  # Keyframes for animations
  keyframes(:spin,
    from: [transform: "rotate(0deg)"],
    to: [transform: "rotate(360deg)"]
  )
end

defmodule LiveStyleDemoWeb.Tokens.Space do
  use LiveStyle

  # CSS variables (can be overridden at runtime via themes)
  vars(
    "1": "0.25rem",
    "2": "0.5rem",
    "4": "1rem",
    "6": "1.5rem",
    "8": "2rem"
  )
end

defmodule LiveStyleDemoWeb.Tokens.Semantic do
  use LiveStyle

  alias LiveStyleDemoWeb.Tokens

  vars(
    text_primary: var({Tokens, :gray_900}),
    fill_surface: var({Tokens, :white})
  )

  # Dark theme overrides
  theme(:dark,
    text_primary: var({Tokens, :gray_50}),
    fill_surface: var({Tokens, :gray_900})
  )
end
```

### 2. Use in Components

Define classes in your LiveView modules and use the `css/1` macro:

```elixir
defmodule MyAppWeb.CardLive do
  use MyAppWeb, :live_view

  alias MyApp.Tokens
  alias MyApp.Tokens.Semantic
  alias MyApp.Tokens.Space

  class(:card,
    padding: var({Space, :"4"}),
    color: var({Semantic, :text_primary}),
    background: var({Semantic, :fill_surface}),
    border_radius: const({Tokens, :radius_lg})
  )

  class(:card_title,
    font_size: const({Tokens, :font_size_lg}),
    font_weight: const({Tokens, :font_weight_bold})
  )

  def render(assigns) do
    ~H"""
    <div {css(:card)}>
      <h2 {css(:card_title)}>Title</h2>
      Content here
    </div>
    """
  end
end
```

### 3. View Transitions

For animated DOM updates, use view transitions:

```elixir
# In your tokens module
view_transition(:todo_item,
  old: [animation: keyframes(:fade_out), animation_duration: "200ms"],
  new: [animation: keyframes(:fade_in), animation_duration: "200ms"]
)

# In your LiveView template
<div
  {css(view_transition({Tokens, :todo_item}))}
  style={"view-transition-name: todo-#{todo.id}"}
  id={"todo-#{todo.id}"}
>
  {todo.title}
</div>
```

## Related

- [LiveStyle](https://github.com/lifeiscontent/live_style) - The main library
- [StyleX](https://stylexjs.com/) - Meta's CSS-in-JS library (inspiration)
- [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view) - Real-time server-rendered HTML

## License

MIT License - see [LICENSE](LICENSE) for details.
