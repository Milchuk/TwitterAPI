defmodule TwitterWeb.TweetsView do
  use TwitterWeb, :view

  def render("index.json", %{tweets: tweets}) do
    render_many(tweets, __MODULE__, "show.json", as: :tweet)
  end

  def render("show.json", %{tweet: tweet}) do
    %{
      id: tweet.id,
      text: tweet.text,
      user_id: tweet.user_id,
      id_ref: tweet.id_ref,
      likes_amount: tweet.likes_amount,
      inserted_at: tweet.inserted_at
    }
  end
end
