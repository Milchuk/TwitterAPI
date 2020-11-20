defmodule Twitter.Accounts do
  import Bcrypt, only: [verify_pass: 2]
  import Comeonin.Bcrypt, only: [dummy_checkpw: 0]
  import Ecto.Query

  alias Twitter.Accounts.UserQueries
  alias Twitter.Guardian
  alias Twitter.Repo
  alias Twitter.Accounts.User
  

  def create_user(attrs), do: UserQueries.create(attrs)

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  def get_user(id) do
    answer = from user in User, where: user.id == ^id
    Repo.one(answer)
  end
end
