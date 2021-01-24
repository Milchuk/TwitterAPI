defmodule Twitter.Tweets do
  alias Twitter.Tweets.TweetQueries

  def create_tweet(attrs), do: TweetQueries.create(attrs)
  def recent_tweets(), do: TweetQueries.recent()
  def reply_tweets(id), do: TweetQueries.replies(id)
  def get_tweet(id), do: TweetQueries.get(id)
  def all_tweets_from_subscribes(user_id), do: TweetQueries.all_from_subscribes(user_id)
  def liked_tweets_by_subscribes(user_id), do: TweetQueries.liked_by_subscribes(user_id)
end
