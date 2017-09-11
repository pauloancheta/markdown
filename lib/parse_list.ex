defmodule ParseList do
  @formatter_map %{
    "#" => "h1",
    "##" => "h2",
    "###" => "h3",
    "####" => "h4",
    "#####" => "h5",
    "######" => "h6",
  }

  def call([head | tail]) do
    parse_line(tail, [format_html(head)])
  end

  defp parse_line([head | tail], list) do
    parse_line(tail, list ++ [format_html(head)])
  end
  defp parse_line([], result), do: result

  defp format_html(""), do: "<br>"
  defp format_html("\n"), do: "<br>"
  defp format_html("---"), do: "<hr>"
  defp format_html(string) do
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
