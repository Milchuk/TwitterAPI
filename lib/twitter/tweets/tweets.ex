defmodule Twitter.Tweets do
  alias Twitter.Tweets.TweetQueries

  def create_tweet(attrs), do: TweetQueries.create(attrs)
  def recent_tweets(), do: TweetQueries.recent()
  def reply_tweets(id), do: TweetQueries.replies(id)
  def get_tweet(id), do: TweetQueries.get(id)
end
