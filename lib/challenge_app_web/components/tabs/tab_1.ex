defmodule ChallengeAppWeb.Tabs.Tab1 do
  use ChallengeAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <a href={~p"/page_b"}>B</a>
    """
  end
end
