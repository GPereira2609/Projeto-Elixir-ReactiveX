defmodule FormValidadorWeb.PageController do
  use FormValidadorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
