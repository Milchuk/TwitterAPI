defmodule Twitter.Tweets.TweetQueries do

  alias Twitter.Repo
  alias Twitter.Tweets.Tweet

  import Ecto.Query

  def create(attrs \\ %{}) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

  def recent() do
    tweets_w_likes = count_likes()
    query = from tweet in tweets_w_likes, order_by: [desc: tweet.inserted_at]
    Repo.all(query)
  end

  def replies(id) do
    tweets_w_likes = count_likes()
    reps = from tweet in tweets_w_likes, where: tweet.id_ref == ^id
    Repo.all(reps)
  end

  def get(id) do
    tweets_w_likes = count_likes()
    tweet = from t in tweets_w_likes, where: t.id == ^id
    Repo.one(tweet)
  end

  def count_likes() do
    from tweet in Tweet,
            left_join: like in assoc(tweet, :likes),
            group_by: tweet.id,
            select_merge: %{likes_num: count(like.id)}
  end
end
