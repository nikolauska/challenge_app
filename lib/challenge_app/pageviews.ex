defmodule ChallengeApp.Pageviews do
  @moduledoc """
  The Pageviews context.
  """

  import Ecto.Query, warn: false
  alias ChallengeApp.Repo

  alias ChallengeApp.Pageviews.Pageview

  @doc """
  Returns the list of pageviews.

  ## Examples

      iex> list_pageviews()
      [%Pageview{}, ...]

  """
  def list_pageviews do
    Repo.all(Pageview)
  end

  @doc """
  Gets a single pageview.

  Raises `Ecto.NoResultsError` if the Pageview does not exist.

  ## Examples

      iex> get_pageview!(123)
      %Pageview{}

      iex> get_pageview!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pageview!(id), do: Repo.get!(Pageview, id)

  @doc """
  Creates a pageview.

  ## Examples

      iex> create_pageview(%{field: value})
      {:ok, %Pageview{}}

      iex> create_pageview(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pageview(attrs \\ %{}) do
    %Pageview{}
    |> Pageview.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pageview.

  ## Examples

      iex> update_pageview(pageview, %{field: new_value})
      {:ok, %Pageview{}}

      iex> update_pageview(pageview, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pageview(%Pageview{} = pageview, attrs) do
    pageview
    |> Pageview.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pageview.

  ## Examples

      iex> delete_pageview(pageview)
      {:ok, %Pageview{}}

      iex> delete_pageview(pageview)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pageview(%Pageview{} = pageview) do
    Repo.delete(pageview)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pageview changes.

  ## Examples

      iex> change_pageview(pageview)
      %Ecto.Changeset{data: %Pageview{}}

  """
  def change_pageview(%Pageview{} = pageview, attrs \\ %{}) do
    Pageview.changeset(pageview, attrs)
  end
end
