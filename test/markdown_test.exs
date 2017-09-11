defmodule MarkdownTest do
  use ExUnit.Case
  doctest Markdown

  test "split the file on every line break" do
    count = "a\nb"
            |> Markdown.call
            |> Enum.count
    assert count == 2
  end

  test "paragraphs" do
    test_string = "a\nb"
    assertion = ["<p>a</p>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end

  test "heading 1" do
    test_string = "# a\nb"
    assertion = ["<h1>a</h1>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end

  test "heading 1 with multiple words in one line" do
    test_string = "# a 1\nb"
    assertion = ["<h1>a 1</h1>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end

  test "heading 2 with multipile words" do
    test_string = "## a 1\nb"
    assertion = ["<h2>a 1</h2>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end

  test "invalid formatter" do
    test_string = "##a 1\nb"
    assertion = ["<p>##a 1</p>", "<p>b</p>"]
    assert Markdown.call(test_string) == assertion
  end
end
