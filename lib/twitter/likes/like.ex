defmodule Twitter.Likes.Like do
    use Ecto.Schema
  
    import Ecto.Changeset
  
    alias Ecto.Changeset
    alias Twitter.Tweets.Tweet
    alias Twitter.Likes.Like
  
    schema "likes" do
      field :tweet_ident, :string
      field :user_ident, :string

      belongs_to :tweet, Tweet
  
      timestamps()
    end
  
    def changeset(%Like{} = like, attrs) do
      like
      |> cast(attrs, [:tweet_ident, :user_ident])
      |> validate_required([:tweet_ident, :user_ident])
    end
end