defmodule Twitter.Subscribes do
    alias Twitter.Subscribes.SubscribeQueries
  
    def add_subscribe(attrs), do: SubscribeQueries.create(attrs)

  end