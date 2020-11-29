defmodule TwitterWeb.UsersView do
  use TwitterWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email, username: user.username}
  end
end
