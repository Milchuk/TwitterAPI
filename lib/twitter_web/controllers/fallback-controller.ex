defmodule Twitter.FallbackController do
    use TwitterWeb, :controller
  
    def call(conn, {:error, :unauthorized}) do
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Login error"})
    end
    
  end