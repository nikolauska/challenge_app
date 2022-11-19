defmodule ChallengeApp.Pageviews do
  @moduledoc """
  The Pageviews context.
  """

  import Ecto.Query, warn: false
  alias ChallengeApp.Repo

  alias ChallengeApp.Sessions.Session
  alias ChallengeApp.Pageviews.Pageview

  @doc """
  Create new pageview
  """
  def create(%Session{} = session, view) when is_binary(view) do
    %Pageview{}
    |> Pageview.changeset(%{session_id: session.id, view: view, engagement_time: 0})
    |> Repo.insert!()
  end

  @doc """
  Update engagement time with seconds
  """
  def update_engagement(pageview_id, 0), do: :ok

  def update_engagement(pageview_id, seconds)
      when is_integer(pageview_id) and is_integer(seconds) and seconds > 0 do
    # Pageview should never be updated other than session
    # In case this is not a case we want to get the latest value from database and add to it
    # TODO: Maybe there is a solution in the changeset for this usecase?
    Repo.query(
      """
      update pageviews
      set engagement_time = engagement_time + $1::integer
      where id = $2::bigint
      """,
      [seconds, pageview_id]
    )
    |> case do
      {:ok, _} ->
        :ok

      {:error, err} ->
        {:error, err}
    end
  end
end
