defmodule Mix.Tasks.Fs.GetCollection do
  @moduledoc "GENERATE POSTMAN COLECTIONS"
  @shortdoc "GENERATE POSTMAN COLECTIONS"
  alias FastPostmanCollection.Config
  @requirements ["app.start"]
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    file_path = Config.get_file_path_to_generate()

    case File.write(Config.get_file_path_to_generate(), FastPostmanCollection.generate_json()) do
      :ok ->
        Mix.shell().info("""

        --->>>> FastPostmanCollection GENERATE COLECTIONS
        FILE_PATH -> #{file_path}

        """)

      {:error, reason} ->
        Mix.shell().info("""
        --->>>> POSTMAN GENERATE COLECTIONS
        FILE_PATH -> #{reason}
        """)
    end
  end
end
