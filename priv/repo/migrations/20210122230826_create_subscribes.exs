defmodule Twitter.Repo.Migrations.CreateSubscribes do
  use Ecto.Migration

  def change do
    create table :subscribes do
      add :user_id, references(:users, on_delete: :delete_all)
      add :user_id_subscribed_to, :integer, null: false

      timestamps()
    end
  end
end
