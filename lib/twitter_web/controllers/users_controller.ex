defmodule TwitterWeb.UsersController do
  use TwitterWeb, :controller

  alias Twitter.Accounts

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params) do
      render(conn, "show.json", %{user: user})
    end
  end

end
