defmodule Twitter.Subscribes.SubscribeQueries do

    alias Twitter.Repo
    alias Twitter.Subscribes.Subscribe
  
    def create(attrs \\ %{}) do
      %Subscribe{}
      |> Subscribe.changeset(attrs)
      |> Repo.insert()
    end
    
  end