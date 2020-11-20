defmodule TwitterWeb.UsersController do
  use TwitterWeb, :controller

  alias Twitter.Accounts
  alias Twitter.Guardian

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect(user)
    conn |> render("user.json", res: user)
 end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
      end
  end
end
