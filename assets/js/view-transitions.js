/**
 * Phoenix LiveView View Transitions Adapter
 * 
 * A standalone adapter that integrates the CSS View Transitions API with Phoenix LiveView.
 * Works with LiveView 1.1.18+ which provides the `onDocumentPatch` DOM callback.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/API/View_Transitions_API
 * @see https://github.com/phoenixframework/phoenix_live_view/pull/4043
 * 
 * ## Usage
 * 
 * ```javascript
 * import { Socket } from "phoenix"
 * import { LiveSocket } from "phoenix_live_view"
 * import { createViewTransitionDom } from "./view-transitions"
 * 
 * const liveSocket = new LiveSocket("/live", Socket, {
 *   dom: createViewTransitionDom()
 * })
 * ```
 * 
 * ## Triggering Transitions
 * 
 * From your LiveView, push an event before the DOM update:
 * 
 * ```elixir
 * def handle_event("shuffle", _params, socket) do
 *   {:noreply,
 *    socket
 *    |> assign(items: Enum.shuffle(socket.assigns.items))
 *    |> push_event("start-view-transition", %{}, dispatch: :before)}
 * end
 * ```
 * 
 * ## Options
 * 
 * The `start-view-transition` event accepts these options:
 * 
 * - `types` - Array of transition types for CSS matching (e.g., ["shuffle"])
 * 
 * ## Styling Transitions
 * 
 * Elements participate in transitions when they have `view-transition-name` set
 * in their inline style:
 * 
 * ```html
 * <div style="view-transition-class: x1abc; view-transition-name: card-1">Card 1</div>
 * ```
 * 
 * Style transitions with CSS using view-transition-class:
 * 
 * ```css
 * ::view-transition-group(.x1abc) {
 *   animation-duration: 0.3s;
 * }
 * 
 * ::view-transition-old(.x1abc) {
 *   animation: fade-out 0.2s ease-out;
 * }
 * 
 * ::view-transition-new(.x1abc) {
 *   animation: fade-in 0.3s ease-out;
 * }
 * ```
 * 
 * ## Browser Support
 * 
 * View Transitions are supported in Chrome 111+, Edge 111+, and Safari 18+.
 * In unsupported browsers, DOM updates happen immediately without animation.
 */

/**
 * Creates a DOM adapter for Phoenix LiveSocket that enables View Transitions.
 * 
 * @param {Object} [options] - Configuration options
 * @param {Object} [options.dom] - Existing DOM callbacks to merge with
 * @returns {Object} DOM configuration object for LiveSocket
 * 
 * @example
 * // Basic usage
 * const liveSocket = new LiveSocket("/live", Socket, {
 *   dom: createViewTransitionDom()
 * })
 * 
 * @example
 * // With existing DOM callbacks
 * const liveSocket = new LiveSocket("/live", Socket, {
 *   dom: createViewTransitionDom({
 *     dom: {
 *       onBeforeElUpdated(from, to) {
 *         // your custom logic
 *         return true
 *       }
 *     }
 *   })
 * })
 */
// Global state exposed for hooks to check
window.__viewTransitionPending = false
window.__vtCounter = 0

export function createViewTransitionDom(options = {}) {
  const existingDom = options.dom || {}
  
  // State for pending transitions
  let transitionTypes = []

  // Listen for view transition events from LiveView
  // Event is dispatched before the DOM patch when using `dispatch: :before`
  window.addEventListener("phx:start-view-transition", (e) => {
    const opts = e.detail || {}
    
    // Collect transition types for CSS matching
    if (opts.types && Array.isArray(opts.types)) {
      transitionTypes.push(...opts.types)
    }
    
    window.__viewTransitionPending = true
  })

  return {
    ...existingDom,
    
    /**
     * Called before the document is patched.
     * Wraps the DOM update in a View Transition when one is scheduled.
     */
    onDocumentPatch(start) {
      // Call existing onDocumentPatch if present
      const existingOnDocumentPatch = existingDom.onDocumentPatch
      
      const update = () => {
        // Reset state
        const types = transitionTypes
        transitionTypes = []
        
        // Run the DOM update (morphdom)
        if (existingOnDocumentPatch) {
          existingOnDocumentPatch(start)
        } else {
          start()
        }
        
        // Reset pending flag after DOM update
        window.__viewTransitionPending = false
      }

      // Only use View Transitions if one was scheduled
      if (!window.__viewTransitionPending) {
        update()
        return
      }
      
      // Check for View Transitions API support
      if (!document.startViewTransition) {
        update()
        return
      }

      // Start the view transition
      // Names are already applied by hooks on mount
      // Firefox 144+ doesn't support callbackOptions yet, so fallback to basic version
      try {
        document.startViewTransition({
          update,
          types: transitionTypes.length ? transitionTypes : ["same-document"],
        })
      } catch (error) {
        document.startViewTransition(update)
      }
    },

    /**
     * Called before an element is updated during morphdom.
     * Passes through to any existing onBeforeElUpdated callback.
     */
    onBeforeElUpdated(fromEl, toEl) {
      if (existingDom.onBeforeElUpdated) {
        return existingDom.onBeforeElUpdated(fromEl, toEl)
      }
      return true
    }
  }
}

/**
 * Default export for convenience
 */
export default createViewTransitionDom
