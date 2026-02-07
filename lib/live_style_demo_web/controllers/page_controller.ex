defmodule LiveStyleDemoWeb.PageController do
  use LiveStyleDemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def interop(conn, _params) do
    render(conn, :interop, opacity: 0.72)
  end
end
