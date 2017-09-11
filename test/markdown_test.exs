defmodule MarkdownTest do
  use ExUnit.Case
  doctest Markdown

  test "split the file on every line break" do
    count = "a\nb"
            |> Markdown.call
            |> Enum.count
    assert count == 2
  end

  @tag :skip
  test "test paragraphs" do
    test_string = "a\nb"
    assertion = ["<p>a</p>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end

  @tag :skip
  test "test heading 1" do
    test_string = "# a\nb"
    assertion = ["<h1>a</h1>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end
end
