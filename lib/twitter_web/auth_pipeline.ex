defmodule TwitterWeb.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :twitter,
    module: Twitter.Guardian,
    error_handler: TwitterWeb.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end