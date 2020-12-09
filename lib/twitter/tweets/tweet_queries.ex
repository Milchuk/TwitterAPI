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
    Repo.all(query)
  end

  def replies(id) do
    reps = from tweet in Tweet, where: tweet.id_ref == ^id
    Repo.all(reps)
  end

  def get(id) do
    answer = from tweet in Tweet, where: tweet.id == ^id
    Repo.one(answer)
  end

end
