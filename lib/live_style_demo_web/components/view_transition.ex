defmodule LiveStyleDemoWeb.ViewTransition do
  @moduledoc """
  A component that enables CSS View Transitions for its children.

  Similar to React's `<ViewTransition>` component, this wraps content and
  automatically manages `view-transition-name` during LiveView updates.

  **Important:** The wrapper div needs to be a real box in the layout for view
  transitions to work. Apply your visual styles directly to the wrapper via the
  `class` attribute - don't use `display: contents` as it removes the element
  from the box tree and breaks view transition snapshots.

  ## Setup

  Add the hook definition to your layout or root template (only needs to be done once):

      <LiveStyleDemoWeb.ViewTransition.hook_definition />

  ## Usage

      # Apply styles directly to the wrapper (recommended)
      <.view_transition id="card-1" class="card">
        <h3>Card title</h3>
        <p>Card content</p>
      </.view_transition>

      # With view-transition-class for custom animations
      <.view_transition id="card-1" class="card" view-transition-class="card-transition">
        <h3>Card title</h3>
      </.view_transition>

      # Explicit name for shared element transitions
      <.view_transition id="card-1" class="card" view-transition-name="hero-card">
        <h3>Card title</h3>
      </.view_transition>

  ## Props

    * `id` - Required. Unique ID for the element (used by LiveView's morphdom).
    * `class` - Recommended. CSS classes for the wrapper element.
    * `view-transition-name` - Optional. Explicit name. If not provided, auto-generated.
    * `view-transition-class` - Optional. Class value for CSS styling.
    * All other attributes are passed through to the wrapper div (including `style`, `phx-click`, etc.).

  ## How it works

  1. On mount: Auto-generates a unique `view-transition-name` if not provided
  2. Before update: Applies `view-transition-name` to capture old state
  3. After update: Browser animates between old and new states
  4. On destroy: Can trigger exit animations

  ## Styling

  Use `view-transition-class` to style your transitions:

      <.view_transition id="card-1" class="card" view-transition-class="card-transition">
        ...
      </.view_transition>

  Then in CSS:

      ::view-transition-group(.card-transition) {
        animation-duration: 300ms;
      }
  """

  use Phoenix.Component

  @doc """
  Renders the colocated hook definition for ViewTransition.

  This must be included once in your application (e.g., in root.html.heex or a layout)
  to register the hook with LiveView's colocated hooks system.

  ## Example

      # In root.html.heex or layouts/app.html.heex
      <LiveStyleDemoWeb.ViewTransition.hook_definition />
  """
  def hook_definition(assigns) do
    assigns = assign_new(assigns, :id, fn -> "view-transition-hook-def" end)

    ~H"""
    <div id={@id} hidden>
      <script :type={Phoenix.LiveView.ColocatedHook} name=".ViewTransition">
        export default {
          mounted() {
            // Generate unique name if not provided, store on element
            if (!this.el.__vtName) {
              this.el.__vtName = this.el.dataset.viewTransitionName || `_vt_${window.__vtCounter++}_`;
            }
            // Apply immediately so transitions work on first interaction
            this.el.style.viewTransitionName = this.el.__vtName;
            if (this.el.dataset.viewTransitionClass) {
              this.el.style.viewTransitionClass = this.el.dataset.viewTransitionClass;
            }
          },

          beforeUpdate() {
            // Name is already applied from mount
          },

          updated() {
            // Keep the name applied (in case morphdom removed it)
            this.el.style.viewTransitionName = this.el.__vtName;
            if (this.el.dataset.viewTransitionClass) {
              this.el.style.viewTransitionClass = this.el.dataset.viewTransitionClass;
            }
          },

          destroyed() {
            // Element is being removed
          }
        }
      </script>
    </div>
    """
  end

  attr(:id, :string, required: true, doc: "Unique ID for the element")

  attr(:"view-transition-name", :string,
    default: nil,
    doc: "Explicit view-transition-name (auto-generated if not provided)"
  )

  attr(:"view-transition-class", :string,
    default: nil,
    doc: "view-transition-class for CSS styling"
  )

  attr(:rest, :global)

  slot(:inner_block, required: true)

  @doc """
  Renders a view transition wrapper element.

  The element automatically manages `view-transition-name` during LiveView
  updates to enable smooth CSS View Transitions.

  Apply your visual styles directly to the wrapper via the `class` attribute.

  ## Examples

      # Apply styles directly to wrapper (recommended)
      <.view_transition id={"card-\#{card.id}"} class="card">
        <h3>Title</h3>
        <p>Content</p>
      </.view_transition>

      # With view-transition-class for custom animations
      <.view_transition id={"card-\#{card.id}"} class="card" view-transition-class="card-transition">
        <h3>Title</h3>
      </.view_transition>

      # Explicit name for shared element transitions
      <.view_transition id="hero-image" class="hero-image" view-transition-name="hero">
        <img src="..." />
      </.view_transition>
  """
  def view_transition(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook=".ViewTransition"
      data-view-transition-name={assigns[:"view-transition-name"]}
      data-view-transition-class={assigns[:"view-transition-class"]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end
end
