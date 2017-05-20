defmodule TurkishWeb.PageControllerTest do
  use TurkishWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "nouns"
  end
end
