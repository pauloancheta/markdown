defmodule Markdown do
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
end
