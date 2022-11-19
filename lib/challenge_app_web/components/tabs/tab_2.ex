defmodule ChallengeAppWeb.Tabs.Tab2 do
  use ChallengeAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <a href={~p"/page_a"}>A</a>
    """
  end
end
