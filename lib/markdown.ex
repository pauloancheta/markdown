defmodule Markdown do
  def call(file) do
    {:ok, content} = file |> File.read

    content = content
              |> String.split("\n")
              |> ParseList.call
              |> Enum.join

    File.write("sample.html", generate_html(content))
  end

  defp generate_html(content) do
    {:ok, css} = File.read("./support/github.css")
    """
<html>
  <head><style>#{css}</style></head>
  <body>
    #{content}
  </body>
</html>
    """
  end
end
