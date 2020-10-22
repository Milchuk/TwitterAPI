defmodule Twitter.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table :users do
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :username, :string, null: false
      add :name, :string
      add :bio, :string

      timestamps()
    end
  end
end
