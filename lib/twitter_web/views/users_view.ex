defmodule TwitterWeb.UsersView do
  use TwitterWeb, :view

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("user.json", %{res: res}) do
    %{email: res.email, username: res.username}
  end
end
