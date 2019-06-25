defmodule VoiceWeb.Auth.Google do
  def get_token() do
    jwt = generate_jwt()

    params = %{
      assertion: jwt,
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer"
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

  def generate_jwt do
    extra_claims = %{
      "iss" => iss(),
      "scope" => "https://www.googleapis.com/auth/cloud-platform",
      "aud" => "https://www.googleapis.com/oauth2/v4/token"
    }
    signer = Joken.Signer.create("RS256", %{"pem" => pem()}, %{"kid" => kid()})
    VoiceWeb.Auth.Token.generate_and_sign!(extra_claims, signer)
  end

  def iss do
    System.get_env("GOOGLE_CLIENT_EMAIL")
  end

  def kid do
    System.get_env("GOOGLE_PRIVATE_KEY_ID")
  end

  def pem do
    System.get_env("GOOGLE_PRIVATE_KEY")
    |> String.replace(~r/\\n/, "\n")
  end
end
