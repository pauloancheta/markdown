defmodule ParseListTest do
  use ExUnit.Case
  doctest ParseList

  test "paragraphs" do
    test_string = ["a", "b"]
    assertion = ["<p>a</p>", "<p>b</p>"]
    assert ParseList.call(test_string) == assertion
  end

  test "heading 1" do
    test_string = ["# a", "b"]
    assertion = ["<h1>a</h1>", "<p>b</p>"]
    assert ParseList.call(test_string) == assertion
  end

  test "heading 1 with multiple words in one line" do
    test_string = ["# a 1", "b"]
    assertion = ["<h1>a 1</h1>", "<p>b</p>"]
    assert ParseList.call(test_string) == assertion
  end

  test "heading 2 with multipile words" do
    test_string = ["## a 1", "b"]
    assertion = ["<h2>a 1</h2>", "<p>b</p>"]
    assert ParseList.call(test_string) == assertion
  end

  test "invalid formatter" do
    test_string = ["##a 1", "b"]
    assertion = ["<p>##a 1</p>", "<p>b</p>"]
    assert ParseList.call(test_string) == assertion
  end

  test "blank space" do
    test_string = ["", "\n\n"]
    assertion = ["<br>", "<br>"]
    assert ParseList.call(test_string) == assertion
  end

  test "horizontal line break" do
    test_string = ["---"]
    assertion = ["<hr>"]
    assert ParseList.call(test_string) == assertion
  end

  @tag :skip
  test "italicized word in paragraph" do
    test_string = "_hello_"
    assertion = "<p><em>hello</em></p>"
    assert ParseList.call(test_string) == assertion
  end
end
