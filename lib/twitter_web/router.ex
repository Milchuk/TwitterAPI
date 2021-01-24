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

    #создание пользователя
    resources "/sign_up", UsersController, only: [:create]
    post "/sign_in", UsersController, :sign_in
    get "/tweets/:id", TweetsController, :show
    #cоздание твита/вывод всех твитов отсортированных по времени
    resources "/tweets", TweetsController, only: [:index, :create]
    #создание лайка
    post "/my_like", TweetsController, :add_like
    #создание подписки
    post "/my_sub", UsersController, :add_subscribe
    #не пользовался раньше твиттером и не совсем понимаю что именно feed, у меня feed - это все твиты тех, на кого подписан
    get "/feed/:user_id", TweetsController, :feed
    #feed_likes - твиты, лайкнутые теми, на кого подписан пользователь
    get "/feed_likes/:user_id", TweetsController, :feed_likes
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
