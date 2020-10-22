defmodule TwitterWeb.UsersView do
  use TwitterWeb, :view

  def render("show.json", %{user: user}) do
    %{
      email: user.email,
      username: user.username
    }
  end
end
