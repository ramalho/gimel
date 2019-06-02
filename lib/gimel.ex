defmodule Gimel do
  @moduledoc """
  Gimel finds Unicode characters by name.
  """

  @doc """
  Build list of uppercase words from a string, splitting hyphenated words.
  """
  def tokenize(text) do
    text
    |> String.upcase()
    |> String.replace("-", " ")
    |> String.split()
  end

  @doc """
  Parse line from UnicodeData.txt.
  """
  def parse(line) do
    [code_str, name | _] = String.split(line, ";")
    code = String.to_integer(code_str, 16)
    {code, name, tokenize(name)}
  end

  @doc """
  Add character words to inverted index.
  """
  def index(inverted_index, char_code, words) do
    Enum.reduce(words, inverted_index, fn word, idx ->
      Map.get_and_update(idx, word, fn
        nil -> {word, MapSet.new([char_code])}
        code_set -> {word, MapSet.put(code_set, char_code)}
      end)
      |> elem(1)
    end)
  end

  @doc """
  Build indexes: first maps each word to a set of characters,
  second maps each character code to the character name.
  """
  def build_indexes(lines) do
    word_idx = %{}
    code_idx = %{}
    indexes = {word_idx, code_idx}

    Enum.reduce(lines, indexes, fn line, {word_idx, code_idx} ->
      {code, name, words} = parse(line)
      {index(word_idx, code, words), Map.put(code_idx, code, name)}
    end)
  end

  @external_resource "priv/UnicodeData.txt"
  @unicodedata File.read!("priv/UnicodeData.txt")
               |> String.trim()
               |> String.split(["\n", "\r", "\r\n"])
  def load_data() do
    build_indexes(@unicodedata)
  end

  @doc """
  Returns set of characters with all query words in their names.
  """
  def search(inverted_index, query) when is_binary(query) do
    search(inverted_index, tokenize(query))
  end

  def search(_, []), do: []

  def search(inverted_index, [first | rest]) do
    inverted_index[first]
    |> intersect_results(inverted_index, rest)
    |> Enum.sort()
  end

  defp intersect_results(nil, _index, _words), do: %MapSet{}

  defp intersect_results(result_set, _index, []), do: result_set

  defp intersect_results(result_set, inverted_index, words) do
    Enum.reduce_while(words, result_set, fn word, result_set ->
      result_set =
        Map.get(inverted_index, word, %MapSet{})
        |> MapSet.intersection(result_set)

      case MapSet.size(result_set) do
        0 -> {:halt, result_set}
        _ -> {:cont, result_set}
      end
    end)
  end
end
