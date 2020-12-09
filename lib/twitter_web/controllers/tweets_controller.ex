defmodule TwitterWeb.TweetsController do
  use TwitterWeb, :controller

  alias Twitter.Tweets
  alias Twitter.Likes
  
  #все ответы на твит с указанным id
  def show(conn, %{"id" => id}) do
    tweets = Tweets.reply_tweets(id)
    render(conn, "index.json", %{tweets: tweets})
  end

  #все твиты
  def index(conn, _) do
    tweets = Tweets.recent_tweets()
    render(conn, "index.json", %{tweets: tweets})
  end

  def add_like(conn, params) do
    with {:ok, like} <- Likes.add_like(params) do
      tweet = Tweets.get_tweet(like.tweet_ident)
      render(conn, "show.json", %{tweet: tweet})
    end
  end

  def create(conn, params) do
    with {:ok, tweet} <- Tweets.create_tweet(params) do
      render(conn, "show.json", %{tweet: tweet})
    end
  end
end
