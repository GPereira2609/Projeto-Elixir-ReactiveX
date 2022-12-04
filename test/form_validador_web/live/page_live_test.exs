defmodule FormValidadorWeb.PageLiveTest do
  use FormValidadorWeb.ConnCase

  import Phoenix.LiveViewTest

  @create_attrs %{
    email: "gabriel@gmail.com",
    cpf: "086.448.354-67",
    rg: "4227952-6"
  }
  @invalid_attrs %{
    email: nil,
    cpf: nil,
    rg: nil
  }

  test "renders form title", %{conn: conn} do
    {:ok, _page_path, html} = live(conn, "/")
    assert html =~ "Criar conta"
  end

  test "saves new account", %{conn: conn} do
    {:ok, page_path, _html} = live(conn, "/")

    assert page_path
      |> form("#user-form", user: @invalid_attrs)
      |> render_change() =~ "Não pode estar vazio"

    {:ok, _, html} = page_path
      |> form("#user-form", user: @create_attrs)
      |> render_change_submit()
      |> follow_redirect(conn, "/")

      assert html =~ "Documentos validados com sucesso"
  end

  test "validates email", %{conn: conn} do
    invalid_email = %{email: "email"}
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
           |> form("#user-form", user: invalid_email)
           |> render_change() =~ "Precisa ter @"
           |> render_change() =~ "Precisa ter algo depois do @"
           |> render_change() =~ "Precisa terminar com .com"
  end

  test "validates cpf", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
      |> form("#user-form", cpf: %{cpf: "a"})
      |> render_change() =~ "Precisa ter pelo menos 11 números"

    assert page_live
      |> form("#user-form", cpf: %{cpf: "a"})
      |> render_change() =~ "Use apenas números sem o espaço(apenas os caracteres . e - são permitidos)"
  end

  test "validates rg", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")

    assert page_live
      |> form("#user-form", rg: %{rg: "a"})
      |> render_change() =~ "Use apenas números sem o espaço (e o dígito no final)"

    assert page_live
      |> form("#user-form", rg: %{rg: ""})
      |> render_change() =~ "Não pode ser vazio"

  end
end
