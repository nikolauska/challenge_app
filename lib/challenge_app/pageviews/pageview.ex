defmodule ChallengeApp.Pageviews.Pageview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pageviews" do
    field :engagement_time, :time
    field :view, :string
    field :session_id, :id

    timestamps()
  end

  @doc false
  def changeset(pageview, attrs) do
    pageview
    |> cast(attrs, [:view, :engagement_time])
    |> validate_required([:view, :engagement_time])
  end
end
