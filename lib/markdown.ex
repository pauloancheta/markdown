defmodule Markdown do
  def call(file) do
    file
    |> String.split("\n")
    |> ParseList.call
  end
end
