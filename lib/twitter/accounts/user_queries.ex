defmodule Twitter.Accounts.UserQueries do

  import Bcrypt, only: [verify_pass: 2]
  import Comeonin.Bcrypt, only: [dummy_checkpw: 0]
  import Ecto.Query

  alias Twitter.Repo
  alias Twitter.Accounts.User
  alias Twitter.Subscribes.Subscribe
  
  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get(id) do
    query = from user in User, where: user.id == ^id
    query
    |>put_subscribes_amount
    |>Repo.one
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

  def put_subscribes_amount(query) do
    from user in query,
            left_join: subscribe in Subscribe,
            group_by: user.id,
            where: user.id == subscribe.user_id_subscribed_to,
            select_merge: %{subscribes_amount: count(subscribe.id)}
  end

  def verify_password(password, %User{} = user) when is_binary(password) do
    if verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

end
