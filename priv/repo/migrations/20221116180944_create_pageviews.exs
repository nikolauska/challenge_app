defmodule ChallengeApp.Repo.Migrations.CreatePageviews do
  use Ecto.Migration

  def change do
    create table(:pageviews) do
      add :view, :text
      add :engagement_time, :integer
      add :session_id, references(:sessions, on_delete: :nothing)

      timestamps()
    end

    create index(:pageviews, [:session_id])
  end
end
