defmodule ChallengeApp.PageviewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChallengeApp.Pageviews` context.
  """

  @doc """
  Generate a pageview.
  """
  def pageview_fixture(attrs \\ %{}) do
    {:ok, pageview} =
      attrs
      |> Enum.into(%{
        engagement_time: ~T[14:00:00],
        view: "some view"
      })
      |> ChallengeApp.Pageviews.create_pageview()

    pageview
  end
end
