defmodule FormValidador.AccountsTest do
  use FormValidador.DataCase

  alias FormValidador.Accounts

  describe "users" do
    alias FormValidador.Accounts.User

    import FormValidador.AccountsFixtures

    @invalid_attrs %{cpf: nil, email: nil, rg: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{cpf: "some cpf", email: "some email", rg: "some rg"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.cpf == "some cpf"
      assert user.email == "some email"
      assert user.rg == "some rg"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{cpf: "some updated cpf", email: "some updated email", rg: "some updated rg"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.cpf == "some updated cpf"
      assert user.email == "some updated email"
      assert user.rg == "some updated rg"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
