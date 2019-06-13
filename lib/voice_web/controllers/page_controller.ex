defmodule VoiceWeb.PageController do
  use VoiceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
