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
    query = from tweet in Tweet, order_by: [desc: tweet.inserted_at]

    query
    |> put_likes_amount
    |> Repo.all
  end

  def replies(id) do
    query = from tweet in Tweet, where: tweet.id_ref == ^id

    query
    |> put_likes_amount
    |> Repo.all
  end

  def get(id) do
    query = from tweet in Tweet, where: tweet.id == ^id

    query
    |> put_likes_amount
    |> Repo.one
  end

  def put_likes_amount(query) do
    from tweet in query,
            left_join: like in assoc(tweet, :likes),
            group_by: tweet.id,
            select_merge: %{likes_amount: count(like.id)}
  end
end
