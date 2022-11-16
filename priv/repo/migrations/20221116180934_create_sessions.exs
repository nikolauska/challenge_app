defmodule ChallengeApp.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :session_id, :text
      add :user_agent, :text

      timestamps()
    end
  end
end
