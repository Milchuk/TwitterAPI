defmodule Twitter.Accounts.UserQueries do

  alias Twitter.Repo
  alias Twitter.Accounts.User

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

end
