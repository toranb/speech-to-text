defmodule VoiceWeb.PageController do
  use VoiceWeb, :controller

  alias VoiceWeb.Auth.Google

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, _params) do
    url = "https://texttospeech.googleapis.com/v1/text:synthesize"
    token = Google.get_token()
    params = get_params()
    %HTTPoison.Response{body: body} = post(url, token, params)

    %{"audioContent" => audio} =
      body
      |> Poison.decode!

    json(conn, %{audio: audio})
  end

  def post(url, token, body) do
    headers = [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json; charset=utf-8"}
    ]

    HTTPoison.post!(url, body, headers)
  end

  def get_params() do
    body = %{
      input: %{
        text: "The fish lives under water"
      },
      voice: %{
        languageCode: "en-gb",
        name: "en-GB-Standard-A",
        ssmlGender: "FEMALE"
      },
      audioConfig: %{
        audioEncoding: "MP3"
      }
    }

    body
    |> Poison.encode!
  end
end
