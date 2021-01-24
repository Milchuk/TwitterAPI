defmodule Twitter.Tweets.TweetQueries do

  alias Twitter.Repo
  alias Twitter.Tweets.Tweet
  alias Twitter.Subscribes.Subscribe
  alias Twitter.Likes.Like

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

  #твиты тех, на кого подписан пользователь
  def all_from_subscribes(user_id) do
    tweets = from tweet in Tweet, 
        join: subscribe in Subscribe,
        on: subscribe.user_id_subscribed_to == tweet.user_id,
        where: subscribe.user_id == ^user_id,
        order_by: [desc: tweet.inserted_at]

    tweets
    |> put_likes_amount
    |> Repo.all
  end

  #твиты, которые лайкнули те, на кого подписан пользователь
  def liked_by_subscribes(user_id) do
     tweets = from tweet in Tweet,
      join: like in Like,
      on: tweet.id == like.tweet_id,
      join: subscribe in Subscribe,
      on: like.user_id == subscribe.user_id_subscribed_to,
      where: subscribe.user_id == ^user_id,
      order_by: [desc: tweet.inserted_at]

    tweets
    |> put_likes_amount
    |> Repo.all
  end
  
  def put_likes_amount(query) do
    from tweet in query,
            left_join: like in assoc(tweet, :likes),
            group_by: tweet.id,
            select_merge: %{likes_amount: count(like.id)}
  end
end
