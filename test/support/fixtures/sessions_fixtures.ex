defmodule ChallengeApp.SessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChallengeApp.Sessions` context.
  """

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        session_id: "some session_id",
        user_agent: "some user_agent"
      })
      |> ChallengeApp.Sessions.create_session()

    session
  end
end
