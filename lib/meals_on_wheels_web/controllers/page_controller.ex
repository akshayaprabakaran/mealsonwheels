defmodule MealsOnWheelsWeb.PageController do
  use MealsOnWheelsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
