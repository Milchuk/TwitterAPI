defmodule Twitter.Accounts do
  alias Twitter.Accounts.UserQueries

  def create_user(attrs), do: UserQueries.create(attrs)

end
