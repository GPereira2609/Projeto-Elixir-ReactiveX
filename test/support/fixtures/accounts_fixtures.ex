defmodule FormValidador.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FormValidador.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        cpf: "some cpf",
        email: "some email",
        rg: "some rg"
      })
      |> FormValidador.Accounts.create_user()

    user
  end
end
