defmodule Markdown do
  @formatter_map %{
    "#" => "h1",
    "##" => "h2",
    "###" => "h3",
    "####" => "h4",
    "#####" => "h5",
    "######" => "h6",
  }

  def call(file) do
    file
    |> String.split("\n")
    |> format_to_html
  end

  def format_to_html([head | tail]) do
    format_to_html(tail, [format(head)])
  end
  def format_to_html([]), do: nil
  def format_to_html([head | tail], list) do
    format_to_html(tail, list ++ [format(head)])
  end
  def format_to_html([], result), do: result

  defp format(string) do
    {formatter, parsed_string} = find_formatter(string)

    "<#{formatter}>#{parsed_string}</#{formatter}>"
  end

  defp find_formatter(string) do
    [formatter | tail] = string |> String.split

    case Map.fetch(@formatter_map, formatter) do
      {:ok, formatter} ->
        {formatter, Enum.join(tail, " ")}
      :error ->
        {"p", string}
    end
  end
end
