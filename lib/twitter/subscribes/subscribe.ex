defmodule Twitter.Subscribes.Subscribe do
    use Ecto.Schema
  
    import Ecto.Changeset
  
    alias Twitter.Accounts.User
    alias Twitter.Subscribes.Subscribe
  
    @required [:user_id, :user_id_subscribed_to]

    schema "subscribes" do
      field :user_id_subscribed_to, :integer

      belongs_to :user, User
  
      timestamps()
    end
  
    def changeset(%Subscribe{} = subscribe, attrs) do
      subscribe
      |> cast(attrs, @required )
      |> validate_required(@required )
    end

  end