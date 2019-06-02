defmodule Gimel.CLI do
  @moduledoc """
  Gimel command-line interface
  """

  def show(code, code_idx) do
    char = <<code::utf8>>

    code_fmt =
      code
      |> Integer.to_string(16)
      |> String.pad_leading(4, ["0"])

    "U+#{code_fmt}\t#{char}\t#{code_idx[code]}"
  end

  def repl(word_idx, code_idx, query \\ "") do
    unless query == "/q" do
      if query == "" do
        IO.puts("Enter /q to quit.")
      else
        found = Gimel.search(word_idx, query)
        Enum.each(found, &IO.puts(show(&1, code_idx)))
        IO.puts("(#{length(found)} found)")
      end

      query = IO.gets("Search: ") |> String.trim()
      repl(word_idx, code_idx, query)
    end
  end

  def main(args \\ []) do
    {word_idx, code_idx} = Gimel.load_data()
    repl(word_idx, code_idx, Enum.join(args, " "))
  end
end
