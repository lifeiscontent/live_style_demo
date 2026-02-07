defmodule LiveStyleDemoWeb.PageControllerTest do
  use LiveStyleDemoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end

  test "GET /interop", %{conn: conn} do
    conn = get(conn, ~p"/interop")
    html = html_response(conn, 200)
    assert html =~ "LiveStyle HEEx interop demo"
    assert html =~ "local dynamic MFA with dynamic assign"
  end
end
