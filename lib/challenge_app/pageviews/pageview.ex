defmodule ChallengeApp.Pageviews.Pageview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pageviews" do
    field(:engagement_time, :integer)
    field(:view, :string)
    field(:session_id, :id)

    timestamps()
  end

  @doc false
  def changeset(pageview, attrs) do
    pageview
    |> cast(attrs, [:session_id, :view, :engagement_time])
    |> validate_required([:session_id, :view, :engagement_time])
  end
end
