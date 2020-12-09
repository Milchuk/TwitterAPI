defmodule Twitter.Likes.LikeQueries do

    alias Twitter.Repo
    alias Twitter.Likes.Like
  
    import Ecto.Query
  
    def create(attrs \\ %{}) do
      %Like{}
      |> Like.changeset(attrs)
      |> Repo.insert()
    end
  
    def count(ident) do
        str_id = Integer.to_string(ident)
        likes = from like in Like, where: like.tweet_ident == ^str_id
        Repo.all(likes)
    end
  end