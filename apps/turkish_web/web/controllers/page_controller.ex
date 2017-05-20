defmodule TurkishWeb.PageController do
  use TurkishWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def decline(conn, %{"noun" => ""}) do
    conn
    |> put_flash(:error, "Please enter a noun")
    |> render("index.html")
  end
  def decline(conn, %{"noun" => noun}) do
    conn
    |> assign(:nominative, noun)
    |> assign(:accusative, Turkish.noun_to_accusative(noun))
    |> assign(:dative, Turkish.noun_to_dative(noun))
    |> assign(:locative, Turkish.noun_to_locative(noun))
    |> render("index.html")
  end
end
