defmodule TwitterWeb.Router do
  use TwitterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug TwitterWeb.AuthPipeline
  end

  scope "/", TwitterWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TwitterWeb do
    pipe_through :api

    resources "/sign_up", UsersController, only: [:create]
    post "/sign_in", UsersController, :sign_in
    get "/tweets/:id", TweetsController, :show
    resources "/tweets", TweetsController, only: [:index, :create]
    post "/my_tweet", TweetsController, :add_like

  end

  scope "/api", TwitterWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/my_user", UsersController, :show
    
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TwitterWeb.Telemetry
    end
  end
end
