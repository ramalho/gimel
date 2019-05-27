defmodule Gimel.Endpoints do
  import Plug.Conn

  @indices Gimel.load_data()

  def search(conn, query) do
    {word_idx, _code_idx} = @indices
    codes = Gimel.search(word_idx, query)

    body =
      codes
      |> Stream.map(&<<&1::utf8>>)
      |> Enum.join(" ")

    conn
    |> put_resp_header("content-type", "text/plain; charset=utf-8")
    |> send_resp(200, body)
  end
end
