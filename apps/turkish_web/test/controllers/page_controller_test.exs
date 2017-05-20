defmodule TurkishWeb.PageControllerTest do
  use TurkishWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "nouns"
  end

  test "POST /decline", %{conn: conn} do
    conn = post conn, "/decline", [noun: "ev"]
    assert html_response(conn, 200) =~ "nouns"
    assert html_response(conn, 200) =~ "evi"
    assert html_response(conn, 200) =~ "eve"
    assert html_response(conn, 200) =~ "evde"
  end

  test "POST /decline with no noun", %{conn: conn} do
    conn = post conn, "/decline", [noun: ""]
    assert html_response(conn, 200) =~ "Please enter a noun"
  end

end
