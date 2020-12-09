defmodule Twitter.Likes do
    alias Twitter.Likes.LikeQueries
  
    def add_like(attrs), do: LikeQueries.create(attrs)
    def count_likes(ident), do: LikeQueries.count(ident)

  end