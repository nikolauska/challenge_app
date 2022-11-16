defmodule ChallengeApp.PageviewsTest do
  use ChallengeApp.DataCase

  alias ChallengeApp.Pageviews

  describe "pageviews" do
    alias ChallengeApp.Pageviews.Pageview

    import ChallengeApp.PageviewsFixtures

    @invalid_attrs %{engagement_time: nil, view: nil}

    test "list_pageviews/0 returns all pageviews" do
      pageview = pageview_fixture()
      assert Pageviews.list_pageviews() == [pageview]
    end

    test "get_pageview!/1 returns the pageview with given id" do
      pageview = pageview_fixture()
      assert Pageviews.get_pageview!(pageview.id) == pageview
    end

    test "create_pageview/1 with valid data creates a pageview" do
      valid_attrs = %{engagement_time: ~T[14:00:00], view: "some view"}

      assert {:ok, %Pageview{} = pageview} = Pageviews.create_pageview(valid_attrs)
      assert pageview.engagement_time == ~T[14:00:00]
      assert pageview.view == "some view"
    end

    test "create_pageview/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pageviews.create_pageview(@invalid_attrs)
    end

    test "update_pageview/2 with valid data updates the pageview" do
      pageview = pageview_fixture()
      update_attrs = %{engagement_time: ~T[15:01:01], view: "some updated view"}

      assert {:ok, %Pageview{} = pageview} = Pageviews.update_pageview(pageview, update_attrs)
      assert pageview.engagement_time == ~T[15:01:01]
      assert pageview.view == "some updated view"
    end

    test "update_pageview/2 with invalid data returns error changeset" do
      pageview = pageview_fixture()
      assert {:error, %Ecto.Changeset{}} = Pageviews.update_pageview(pageview, @invalid_attrs)
      assert pageview == Pageviews.get_pageview!(pageview.id)
    end

    test "delete_pageview/1 deletes the pageview" do
      pageview = pageview_fixture()
      assert {:ok, %Pageview{}} = Pageviews.delete_pageview(pageview)
      assert_raise Ecto.NoResultsError, fn -> Pageviews.get_pageview!(pageview.id) end
    end

    test "change_pageview/1 returns a pageview changeset" do
      pageview = pageview_fixture()
      assert %Ecto.Changeset{} = Pageviews.change_pageview(pageview)
    end
  end
end
