defmodule Twitter.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Bcrypt, only: [hash_pwd_salt: 1]

  alias Ecto.Changeset
  alias Twitter.Tweets.Tweet
  alias Twitter.Accounts.User
  alias Twitter.Likes.Like

  @required [:email, :password, :password_confirmation]
  @optional [:username]

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :tweets, Tweet
    has_many :likes, Like

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email) 
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hash_pwd_salt(pass))
      _ ->
          changeset
    end
  end
end

