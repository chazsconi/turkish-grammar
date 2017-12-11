defmodule TurkishWeb.PageControllerTest do
  use TurkishWeb.ConnCase

  test "GET /turkish", %{conn: conn} do
    conn = get conn, "/turkish"
    assert html_response(conn, 200) =~ "nouns"
  end

  test "POST /turkish/decline", %{conn: conn} do
    conn = post conn, "/turkish/decline", [noun: "ev"]
    assert html_response(conn, 200) =~ "nouns"
    assert html_response(conn, 200) =~ "evi"
    assert html_response(conn, 200) =~ "eve"
    assert html_response(conn, 200) =~ "evde"
    assert html_response(conn, 200) =~ "evden"
  end

  test "POST /turkish/decline with no noun", %{conn: conn} do
    conn = post conn, "/turkish/decline", [noun: ""]
    assert html_response(conn, 200) =~ "Please enter a noun"
  end

end
