defmodule ChallengeApp.Repo do
  use Ecto.Repo,
    otp_app: :challenge_app,
    adapter: Ecto.Adapters.Postgres
end
