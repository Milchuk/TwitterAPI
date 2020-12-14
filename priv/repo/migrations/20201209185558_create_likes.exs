defmodule Twitter.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table :likes do
      add :tweet_id, references(:tweets, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
