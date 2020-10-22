defmodule Twitter.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Twitter.Tweets.Tweet

  @required [:email, :password_hash, :username]
  @optional [:name, :bio]

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    field :name, :string
    field :bio, :string

    has_many :tweets, Tweet

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> put_password_hash()
  end

  def put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Argon2.add_hash(password))
  end

  def put_password_hash(changeset), do: changeset
end
