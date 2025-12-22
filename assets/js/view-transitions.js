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
 * // Always animate (recommended for apps with view-transition-name on elements)
 * const liveSocket = new LiveSocket("/live", Socket, {
 *   dom: createViewTransitionDom({ animate: "always" })
 * })
 * 
 * // Only animate when explicitly triggered via push_event
 * const liveSocket = new LiveSocket("/live", Socket, {
 *   dom: createViewTransitionDom({ animate: "explicit" })
 * })
 * ```
 * 
 * ## Modes
 * 
 * - `animate: "always"` - Every LiveView DOM patch is wrapped in a view transition.
 *   Elements with `view-transition-name` will animate automatically. This is the
 *   recommended mode as it requires no server-side coordination.
 * 
 * - `animate: "explicit"` - Only patches preceded by a `start-view-transition` event
 *   are animated. Use this for fine-grained control.
 * 
 * ## Triggering Transitions (explicit mode only)
 * 
 * From your LiveView, push an event before the DOM update:
 * 
 * ```elixir
 * def handle_event("shuffle", _params, socket) do
 *   {:noreply,
 *    socket
 *    |> assign(items: Enum.shuffle(socket.assigns.items))
 *    |> push_event("start-view-transition", %{})}
 * end
 * ```
 * 
 * ## Styling Transitions
 * 
 * Elements participate in transitions when they have `view-transition-name` set.
 * Use `view-transition-class` for shared animation styles:
 * 
 * ```html
 * <div style="view-transition-class: card; view-transition-name: card-1">Card 1</div>
 * ```
 * 
 * ```css
 * ::view-transition-group(.card) {
 *   animation-duration: 0.3s;
 * }
 * ```
 * 
 * ## Browser Support
 * 
 * View Transitions are supported in Chrome 111+, Edge 111+, Safari 18+, and Firefox 144+.
 * In unsupported browsers, DOM updates happen immediately without animation.
 */

/**
 * Creates a DOM adapter for Phoenix LiveSocket that enables View Transitions.
 * 
 * @param {Object} [options] - Configuration options
 * @param {string} [options.animate="always"] - When to animate: "always" or "explicit"
 * @param {Object} [options.dom] - Existing DOM callbacks to merge with
 * @returns {Object} DOM configuration object for LiveSocket
 */
// Global state exposed for hooks to check
window.__viewTransitionPending = false
window.__vtCounter = 0

export function createViewTransitionDom(options = {}) {
  const existingDom = options.dom || {}
  const animateMode = options.animate || "always"
  
  // State for pending transitions (used in explicit mode)
  let transitionTypes = []
  let explicitTransitionPending = false

  // Avoid queuing view transitions on rapid patches.
  // Browsers serialize `startViewTransition` calls; if a patch happens while a
  // transition is still running, we prefer to apply the patch immediately.
  let transitionRunning = false

  // Listen for view transition events from LiveView (explicit mode)
  window.addEventListener("phx:start-view-transition", (e) => {
    const opts = e.detail || {}
    
    // Collect transition types for CSS matching
    if (opts.types && Array.isArray(opts.types)) {
      transitionTypes.push(...opts.types)
    }
    
    explicitTransitionPending = true
    window.__viewTransitionPending = true
  })

  return {
    ...existingDom,
    
    /**
     * Called before the document is patched.
     * Wraps the DOM update in a View Transition.
     */
    onDocumentPatch(start) {
      const existingOnDocumentPatch = existingDom.onDocumentPatch
      
      const update = () => {
        // Reset state
        const types = transitionTypes
        transitionTypes = []
        explicitTransitionPending = false
        
        // Run the DOM update (morphdom)
        if (existingOnDocumentPatch) {
          existingOnDocumentPatch(start)
        } else {
          start()
        }
        
        window.__viewTransitionPending = false
      }

      // Check if we should animate this patch
      const shouldAnimate = animateMode === "always" || explicitTransitionPending
      
      if (!shouldAnimate) {
        update()
        return
      }
      
      // Check for View Transitions API support
      if (!document.startViewTransition) {
        update()
        return
      }

      // Mark as pending for hooks
      window.__viewTransitionPending = true

      // If a transition is already in-flight, avoid queueing another.
      if (transitionRunning) {
        update()
        return
      }

      transitionRunning = true

      // Start the view transition
      // Firefox 144+ doesn't support callbackOptions yet, so fallback to basic version
      try {
        const transition = document.startViewTransition({
          update,
          types: transitionTypes.length ? transitionTypes : ["same-document"],
        })

        transition.finished.finally(() => {
          transitionRunning = false
        })
      } catch (error) {
        const transition = document.startViewTransition(update)

        transition.finished.finally(() => {
          transitionRunning = false
        })
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
