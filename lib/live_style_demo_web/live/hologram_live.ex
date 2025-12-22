defmodule LiveStyleDemoWeb.HologramLive do
  use LiveStyleDemoWeb, :live_view

  require LiveStyleDemoWeb.Tokens
  require LiveStyleDemoWeb.BaseStyles

  alias LiveStyleDemoWeb.BaseStyles
  alias LiveStyleDemoWeb.Tokens

  css_keyframes(:holo_shift,
    "0%": %{background_position: "0% 20%"},
    "50%": %{background_position: "65% 0%"},
    "100%": %{background_position: "100% 80%"}
  )

  css_keyframes(:glint,
    # NOTE: translateX(%) is relative to the glint strip width.
    # Use a large range so it sweeps across the whole card.
    "0%": %{transform: "translateX(-220%) translateY(8%) rotate(12deg)", opacity: "0"},
    "12%": %{opacity: "0.75"},
    "55%": %{transform: "translateX(520%) translateY(-6%) rotate(12deg)", opacity: "0.75"},
    "56%": %{opacity: "0"},
    "100%": %{transform: "translateX(520%) translateY(-6%) rotate(12deg)", opacity: "0"}
  )

  css_keyframes(:scan_drift,
    from: %{background_position: "0 0"},
    to: %{background_position: "0 48px"}
  )

  css_class(:grid,
    display: "grid",
    gap: css_var({Tokens, :space, :"6"}),
    grid_template_columns: "repeat(auto-fit, minmax(min(260px, 100%), 1fr))"
  )

  css_class(:holo_card,
    position: "relative",
    isolation: "isolate",
    overflow: "hidden",
    border_radius: css_const({Tokens, :radius, :"3xl"}),
    padding: css_var({Tokens, :space, :"6"}),
    min_height: "15rem",
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    backdrop_filter: "blur(14px) saturate(1.2)",
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    box_shadow:
      "0 1px 0 0 #{css_var({Tokens, :semantic, :border_glass})} inset, 0 30px 90px -78px #{css_var({Tokens, :semantic, :shadow_color_strong})}",
    transform: [
      default: "translateY(0)",
      ":hover": "translateY(-2px)",
      ":focus-within": "translateY(-2px)",
      ":active": "translateY(-1px)"
    ],
    transition: "transform 180ms ease",
    outline: [
      default: "none",
      ":focus-within": "2px solid #{css_var({Tokens, :semantic, :focus_ring})}"
    ],
    outline_offset: [default: "0", ":focus-within": "3px"]
  )

  css_class(:holo_surface,
    position: "absolute",
    inset: "0",
    z_index: "0",
    border_radius: "inherit",
    pointer_events: "none",
    transform: "translateZ(0)",
    background_image:
      "linear-gradient(120deg, color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_primary})} 32%, transparent), color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_accent})} 32%, transparent), color-mix(in oklab, #{css_var({Tokens, :semantic, :highlight_primary})} 52%, transparent)), conic-gradient(from 90deg at 50% 50%, transparent, #{css_var({Tokens, :semantic, :highlight_primary})}, transparent, transparent), radial-gradient(900px circle at 20% 10%, #{css_var({Tokens, :semantic, :glow_primary})}, transparent 55%), radial-gradient(900px circle at 90% 20%, #{css_var({Tokens, :semantic, :glow_secondary})}, transparent 60%)",
    background_size: "180% 180%",
    background_position: "0% 20%",
    background_repeat: "no-repeat",
    mix_blend_mode: "soft-light",
    mask_image: "radial-gradient(140% 120% at 50% 0%, black 55%, transparent 100%)",
    opacity: [
      default: "0.38",
      ":hover": "0.78",
      ":focus-within": "0.78",
      ":active": "0.78"
    ],
    filter: "saturate(1.08) contrast(1.08)",
    will_change: "background-position, opacity",
    animation_name: [
      default: css_keyframes(:holo_shift),
      ":hover": css_keyframes(:holo_shift),
      ":focus-within": css_keyframes(:holo_shift),
      ":active": css_keyframes(:holo_shift),
      "@media (prefers-reduced-motion: reduce)": [
        default: "none",
        ":hover": "none",
        ":focus-within": "none",
        ":active": "none"
      ]
    ],
    animation_duration: [
      default: "7600ms",
      ":hover": "2400ms",
      ":focus-within": "2400ms",
      ":active": "2400ms"
    ],
    animation_timing_function: "ease-in-out",
    animation_direction: "alternate",
    animation_iteration_count: "infinite"
  )

  css_class(:glint,
    position: "absolute",
    inset: "0",
    z_index: "0",
    pointer_events: "none",
    mix_blend_mode: "plus-lighter",
    mask_image: "radial-gradient(140% 120% at 50% 0%, black 65%, transparent 100%)",
    opacity: [
      default: "0.18",
      ":hover": "0.55",
      ":focus-within": "0.55",
      ":active": "0.55",
      "@media (prefers-reduced-motion: reduce)": [
        default: "0",
        ":hover": "0",
        ":focus-within": "0",
        ":active": "0"
      ]
    ],
    transition: "opacity 180ms ease",
    "::before": %{
      content: "''",
      position: "absolute",
      top: "-30%",
      bottom: "-30%",
      width: "28%",
      left: "0",
      will_change: "transform",
      background_image:
        "linear-gradient(90deg, transparent, color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_primary})} 22%, transparent), color-mix(in oklab, #{css_var({Tokens, :semantic, :fill_primary})} 10%, transparent), transparent)",
      filter: "blur(1.5px)",
      animation_name: css_keyframes(:glint),
      animation_duration: "4200ms",
      animation_delay: "-1200ms",
      animation_timing_function: "cubic-bezier(0.2, 0, 0.2, 1)",
      animation_iteration_count: "infinite"
    }
  )

  css_class(:scanlines,
    position: "absolute",
    inset: "0",
    z_index: "0",
    pointer_events: "none",
    border_radius: "inherit",
    opacity: [
      default: "0.08",
      ":hover": "0.12",
      ":focus-within": "0.12",
      ":active": "0.12",
      "@media (prefers-reduced-motion: reduce)": [
        default: "0",
        ":hover": "0",
        ":focus-within": "0",
        ":active": "0"
      ]
    ],
    mix_blend_mode: "overlay",
    background_image:
      "repeating-linear-gradient(180deg, rgb(255 255 255 / 0.18) 0px, rgb(255 255 255 / 0.18) 1px, transparent 1px, transparent 4px)",
    animation_name: css_keyframes(:scan_drift),
    animation_duration: "5200ms",
    animation_timing_function: "linear",
    animation_iteration_count: "infinite"
  )

  css_class(:holo_content,
    position: "relative",
    z_index: "1",
    display: "grid",
    gap: css_var({Tokens, :space, :"3"})
  )

  css_class(:title,
    font_size: css_const({Tokens, :font_size, :lg}),
    font_weight: css_const({Tokens, :font_weight, :bold}),
    letter_spacing: "-0.02em",
    margin_bottom: css_var({Tokens, :space, :"2"})
  )

  css_class(:text,
    color: css_var({Tokens, :semantic, :text_secondary}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    margin_bottom: css_var({Tokens, :space, :"4"})
  )

  css_class(:pill,
    display: "inline-flex",
    align_items: "center",
    gap: css_var({Tokens, :space, :"2"}),
    padding_block: css_var({Tokens, :space, :"1.5"}),
    padding_inline: css_var({Tokens, :space, :"2.5"}),
    border_radius: css_const({Tokens, :radius, :full}),
    font_size: css_const({Tokens, :font_size, :xs}),
    font_weight: css_const({Tokens, :font_weight, :medium}),
    color: css_var({Tokens, :semantic, :text_primary}),
    background_color: css_var({Tokens, :semantic, :fill_glass}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}"
  )

  css_class(:code,
    font_family: css_const({Tokens, :font, :mono}),
    font_size: css_const({Tokens, :font_size, :sm}),
    line_height: css_const({Tokens, :leading, :relaxed}),
    white_space: "pre-wrap",
    color: css_var({Tokens, :semantic, :text_secondary}),
    background_color: css_var({Tokens, :semantic, :fill_muted}),
    border: "1px solid #{css_var({Tokens, :semantic, :border_glass})}",
    border_radius: css_const({Tokens, :radius, :lg}),
    padding: css_var({Tokens, :space, :"4"})
  )

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page_title: "Hologram")
     |> push_event("start-view-transition", %{type: "page"}, dispatch: :before)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.shell
      active="hologram"
      page_title="Hologram"
      page_subtitle="A holographic/glass UI card using gradients, blend modes, and pseudo-elements."
    >
      <div class={css_class([:grid])}>
        <div class={css_class([:holo_card])} tabindex="0">
          <div class={css_class([:holo_surface])} />
          <div class={css_class([:scanlines])} />
          <div class={css_class([:glint])} />

          <div class={css_class([:holo_content])}>
            <div class={css_class([:title])}>Hologram card</div>
            <p class={css_class([:text])}>
              Hover, focus, or tap to intensify the shimmer.
              The effect also runs subtly by default so it’s visible on touch devices.
            </p>

            <div class={css_class([:pill])}>Advanced CSS visuals</div>
          </div>
        </div>

        <div class={css_class([{BaseStyles, :card_base}])}>
          <div class={css_class([:title])}>Recipe</div>
          <p class={css_class([:text])}>
            The trick is to keep the content layer simple and put the drama in a pointer-events-none overlay.
          </p>

          <pre class={css_class([:code])}>
    .holo::before &#123;
    background: conic-gradient(...), radial-gradient(...);
    mix-blend-mode: overlay;
    animation: shift 1.6s linear;
    &#125;
          </pre>

          <.link
            navigate={~p"/color"}
            class={css_class([{BaseStyles, :btn_base}, {BaseStyles, :btn_secondary}])}
          >
            Next: OKLCH demo
          </.link>
        </div>
      </div>
    </.shell>
    """
  end
end
