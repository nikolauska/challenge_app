defmodule ChallengeAppWeb.PageALiveTest do
  use ChallengeAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import ChallengeApp.PagesFixtures

  @create_attrs %{asd: "some asd"}
  @update_attrs %{asd: "some updated asd"}
  @invalid_attrs %{asd: nil}

  defp create_page_a(_) do
    page_a = page_a_fixture()
    %{page_a: page_a}
  end

  describe "Index" do
    setup [:create_page_a]

    test "lists all pages", %{conn: conn, page_a: page_a} do
      {:ok, _index_live, html} = live(conn, ~p"/pages")

      assert html =~ "Listing Pages"
      assert html =~ page_a.asd
    end

    test "saves new page_a", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pages")

      assert index_live |> element("a", "New Page a") |> render_click() =~
               "New Page a"

      assert_patch(index_live, ~p"/pages/new")

      assert index_live
             |> form("#page_a-form", page_a: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page_a-form", page_a: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/pages")

      assert html =~ "Page a created successfully"
      assert html =~ "some asd"
    end

    test "updates page_a in listing", %{conn: conn, page_a: page_a} do
      {:ok, index_live, _html} = live(conn, ~p"/pages")

      assert index_live |> element("#pages-#{page_a.id} a", "Edit") |> render_click() =~
               "Edit Page a"

      assert_patch(index_live, ~p"/pages/#{page_a}/edit")

      assert index_live
             |> form("#page_a-form", page_a: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page_a-form", page_a: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/pages")

      assert html =~ "Page a updated successfully"
      assert html =~ "some updated asd"
    end

    test "deletes page_a in listing", %{conn: conn, page_a: page_a} do
      {:ok, index_live, _html} = live(conn, ~p"/pages")

      assert index_live |> element("#pages-#{page_a.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#page_a-#{page_a.id}")
    end
  end

  describe "Show" do
    setup [:create_page_a]

    test "displays page_a", %{conn: conn, page_a: page_a} do
      {:ok, _show_live, html} = live(conn, ~p"/pages/#{page_a}")

      assert html =~ "Show Page a"
      assert html =~ page_a.asd
    end

    test "updates page_a within modal", %{conn: conn, page_a: page_a} do
      {:ok, show_live, _html} = live(conn, ~p"/pages/#{page_a}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Page a"

      assert_patch(show_live, ~p"/pages/#{page_a}/show/edit")

      assert show_live
             |> form("#page_a-form", page_a: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#page_a-form", page_a: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/pages/#{page_a}")

      assert html =~ "Page a updated successfully"
      assert html =~ "some updated asd"
    end
  end
end
