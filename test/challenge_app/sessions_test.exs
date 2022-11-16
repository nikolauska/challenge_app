defmodule ChallengeApp.SessionsTest do
  use ChallengeApp.DataCase

  alias ChallengeApp.Sessions

  describe "sessions" do
    alias ChallengeApp.Sessions.Session

    import ChallengeApp.SessionsFixtures

    @invalid_attrs %{session_id: nil, user_agent: nil}

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Sessions.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Sessions.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{session_id: "some session_id", user_agent: "some user_agent"}

      assert {:ok, %Session{} = session} = Sessions.create_session(valid_attrs)
      assert session.session_id == "some session_id"
      assert session.user_agent == "some user_agent"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sessions.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      update_attrs = %{session_id: "some updated session_id", user_agent: "some updated user_agent"}

      assert {:ok, %Session{} = session} = Sessions.update_session(session, update_attrs)
      assert session.session_id == "some updated session_id"
      assert session.user_agent == "some updated user_agent"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Sessions.update_session(session, @invalid_attrs)
      assert session == Sessions.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Sessions.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Sessions.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Sessions.change_session(session)
    end
  end
end
