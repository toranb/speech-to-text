defmodule VoiceWeb.Auth.Token do
  use Joken.Config

  @impl true
  def token_config do
    default_claims(default_exp: 3600)
  end
end
