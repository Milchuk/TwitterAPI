defmodule Twitter.Accounts do

  alias Twitter.Accounts.UserQueries
  alias Twitter.Accounts.AuthService

  def create_user(attrs), do: UserQueries.create(attrs)
  def get_user(id), do: UserQueries.get(id)
  def token_sign_in(email, password), do: AuthService.token(email, password)
 
end
