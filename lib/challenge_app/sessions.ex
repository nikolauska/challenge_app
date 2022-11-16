defmodule ChallengeApp.Sessions do
  @moduledoc """
  The Sessions context.
  """

  import Ecto.Query, warn: false
  alias ChallengeApp.Repo

  alias ChallengeApp.Sessions.Session

  @doc """
  Get or create session
  """
  def get_or_create(session_id, user_agent)
      when is_binary(session_id) and is_binary(user_agent) do
    case get(session_id) do
      nil -> create!(session_id, user_agent)
      session -> session
    end
  end

  @doc """
  Get session with session_id
  """
  def get(session_id) when is_binary(session_id) do
    Repo.get_by(Session, session_id: session_id)
  end

  @doc """
  Get session with session_id
  """
  def create!(session_id, user_agent) when is_binary(session_id) and is_binary(user_agent) do
    %Session{}
    |> Session.changeset(%{session_id: session_id, user_agent: user_agent})
    |> Repo.insert!()
  end
end
