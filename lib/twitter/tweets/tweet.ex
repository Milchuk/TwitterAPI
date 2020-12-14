defmodule Twitter.Tweets.Tweet do
  use Ecto.Schema

  import Ecto.Changeset

  alias Twitter.Accounts.User
  alias Twitter.Likes.Like

  @required [:text, :user_id]
  @optional [:id_ref]

  schema "tweets" do
    field :text, :string
    field :id_ref, :string
    field :likes_num, :integer, virtual: true
    
    belongs_to :user, User
    has_many :likes, Like

    timestamps()
  end

  def changeset(tweet, attrs) do
    tweet
    |>cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
