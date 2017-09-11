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
    |> parse_line
  end

  def parse_line([head | tail]) do
    parse_line(tail, [format_html(head)])
  end
  def parse_line([]), do: nil
  def parse_line([head | tail], list) do
    parse_line(tail, list ++ [format_html(head)])
  end
  def parse_line([], result), do: result

  defp find_formatter(string) do
    [formatter | tail] = string |> String.split

    case Map.fetch(@formatter_map, formatter) do
      {:ok, formatter} ->
        {formatter, Enum.join(tail, " ")}
      :error ->
        {"p", string}
    end
  end

  defp format_html(string) do
    {formatter, parsed_string} = find_formatter(string)

    "<#{formatter}>#{parsed_string}</#{formatter}>"
  end
end
