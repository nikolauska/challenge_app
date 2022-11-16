defmodule ChallengeApp.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :session_id, :string
    field :user_agent, :string

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:session_id, :user_agent])
    |> validate_required([:session_id, :user_agent])
  end
end
