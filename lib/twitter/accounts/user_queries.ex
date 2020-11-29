defmodule Twitter.Accounts.UserQueries do

  import Bcrypt, only: [verify_pass: 2]
  import Comeonin.Bcrypt, only: [dummy_checkpw: 0]
  import Ecto.Query

  alias Twitter.Repo
  alias Twitter.Accounts.User

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get(id) do
    answer = from user in User, where: user.id == ^id
    Repo.one(answer)
  end

  def get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end

  def verify_password(password, %User{} = user) when is_binary(password) do
    if verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

end
