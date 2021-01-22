defmodule Twitter.Accounts.AuthService do

    alias Twitter.Accounts.UserQueries
    alias Twitter.Guardian

    def token(email, password) do
        case email_password_auth(email, password) do
          {:ok, user} ->
            Guardian.encode_and_sign(user)
          _ ->
            {:error, :unauthorized}
        end
    end

    defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
        with {:ok, user} <- UserQueries.get_by_email(email),
        do: UserQueries.verify_password(password, user)
    end
end