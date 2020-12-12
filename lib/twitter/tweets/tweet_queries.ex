defmodule Twitter.Tweets.TweetQueries do

  alias Twitter.Repo
  alias Twitter.Tweets.Tweet
  alias Twitter.Likes.Like

  import Ecto.Query

  def create(attrs \\ %{}) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

  def recent() do
    query = from tweet in Tweet, order_by: [desc: tweet.inserted_at]
    Repo.all(query)
  end

  def replies(id) do
    reps = from tweet in Tweet, where: tweet.id_ref == ^id
    Repo.all(reps)
  end

  def get(id) do
    count_likes()
    tweet = from t in Tweet, where: t.id == ^id
    Repo.one(tweet)
  end

  def count_likes() do
    Repo.all(from tweet in Tweet,
            left_join: like in assoc(tweet, :likes),
            group_by: tweet.id,
            select_merge: %{likes_num: count(like.id)})
  end
end
