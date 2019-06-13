defmodule VoiceWeb.Auth.Google do
  def get_token() do
    config = google_configuration()

    params = %{
      assertion: config[:jwt],
      grant_type: config[:grant_type]
    }

    url = "https://www.googleapis.com/oauth2/v4/token"
    response = post(url, params)
    parse_access_token(response)
  end

  def post(url, params) do
    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]

    HTTPoison.post!(url, URI.encode_query(params), headers)
  end

  def parse_access_token(%HTTPoison.Response{body: body}) do
    %{"access_token" => token} =
      body
      |> Poison.decode!()

    token
  end

  def google_configuration do
    Enum.into(Application.get_env(:httpoison, :google), %{})
  end
end
