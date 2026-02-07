defmodule LiveStyleDemoWeb.PageController do
  use LiveStyleDemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
