defmodule LiveStyleDemoWeb.Router do
  use LiveStyleDemoWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {LiveStyleDemoWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LiveStyleDemoWeb do
    pipe_through(:browser)

    live("/", HomeLive)
    live("/todo", TodoLive)
    live("/table", TableLive)
    live("/anchor", AnchorLive)
    live("/scroll", ScrollLive)
    live("/container", ContainerLive)
    live("/has", HasLive)
    live("/popover", PopoverLive)
    live("/transitions", TransitionsLive)
    live("/starting-style", StartingStyleLive)
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveStyleDemoWeb do
  #   pipe_through :api
  # end
end
