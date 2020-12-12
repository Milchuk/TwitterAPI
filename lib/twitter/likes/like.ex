defmodule Twitter.Likes.Like do
    use Ecto.Schema
  
    import Ecto.Changeset
  
    alias Twitter.Tweets.Tweet
    alias Twitter.Likes.Like
  
    schema "likes" do
      field :tweet_id, :integer
      field :user_id, :integer

      belongs_to :tweets, Tweet
  
      timestamps()
    end
  
    def changeset(%Like{} = like, attrs) do
      like
      |> cast(attrs, [:tweet_id, :user_id])
      |> validate_required([:tweet_id, :user_id])
    end
end