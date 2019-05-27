defmodule Gimel.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/search/:q" do
    Gimel.Endpoints.search(conn, q)
  end

  match _ do
    send_resp(conn, 404, "Page Missing")
  end
end
