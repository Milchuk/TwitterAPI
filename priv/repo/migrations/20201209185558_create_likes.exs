defmodule Twitter.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table :likes do
      add :tweet_ident, :string, null: false
      add :user_ident, :string, null: false

      timestamps()
    end
  end
end
