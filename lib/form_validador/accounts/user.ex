defmodule FormValidador.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :cpf, :string
    field :email, :string
    field :rg, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :cpf, :rg])
    |> validate_required([:email, :cpf, :rg])
    |> validate_email()
    |> validate_cpf()
    |> validate_rg()
  end

  defp validate_email(changeset) do
    changeset
     |> validate_format(:email, ~r//, message: "Não pode estar vazio")
     |> validate_format(:email, ~r/@/, message: "Precisa ter o @")
     |> validate_format(:email, ~r/[.com]/, message: "Precisa terminar em .com")
    #  |> validate_lenght(:email, max: 160)
     |> unique_constraint(:email)
  end

  defp validate_cpf(changeset) do
    changeset
     |> validate_format(:cpf, ~r/[0-9].-/, message: "Precisa ter 11 números, . e -")
    #  |> validate_lenght(:cpf, min: 11, max: 14)
     |> unique_constraint(:cpf)
  end

  defp validate_rg(changeset) do
    changeset
     |> validate_format(:rg, ~r/[0-9].-/, message: "Precisa ter 7 números e o dígito final")
    #  |> validate_lenght(:rg, min: 8, max: 9)
     |> unique_constraint(:rg)
  end
end
