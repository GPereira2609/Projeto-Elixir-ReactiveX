defmodule FormValidadorWeb.PageLive do
  use FormValidadorWeb, :live_view

  alias FormValidador.Accounts
  alias FormValidador.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user(%User{})

    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
       |> Accounts.change_user(user_params)
       |> Map.put(:action, :validate)

      {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Documentos validados com sucesso")
         |> push_redirect(to: "/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
