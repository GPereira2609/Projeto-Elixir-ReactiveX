defmodule FormValidador.Repo do
  use Ecto.Repo,
    otp_app: :form_validador,
    adapter: Ecto.Adapters.Postgres
end
