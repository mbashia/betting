defmodule BettingSystem.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false, size: 160
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      add :firstname, :string
      add :lastname, :string
      add :status, :string, default: "active"
      add :role, :string, default: "user"
      add :phone_number, :integer
      timestamps()
    end

    create unique_index(:users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false, size: 32
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
