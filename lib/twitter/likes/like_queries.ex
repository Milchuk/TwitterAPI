defmodule Twitter.Likes.LikeQueries do

    alias Twitter.Repo
    alias Twitter.Likes.Like
  
    def create(attrs \\ %{}) do
      %Like{}
      |> Like.changeset(attrs)
      |> Repo.insert()
    end
    
  end