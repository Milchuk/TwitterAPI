defmodule TwitterWeb.TweetsView do
  use TwitterWeb, :view

  alias Twitter.Likes

  def render("index.json", %{tweets: tweets}) do
    render_many(tweets, __MODULE__, "show.json", as: :tweet)
  end

  def render("show.json", %{tweet: tweet}) do
    #likes_num = length(Likes.count_likes(tweet.id))
    %{
      id: tweet.id,
      text: tweet.text,
      id_ref: tweet.id_ref,
      #likes_num: likes_num,
      inserted_at: tweet.inserted_at
    }
  end
end
