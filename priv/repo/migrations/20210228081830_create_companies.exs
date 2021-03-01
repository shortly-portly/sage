defmodule Sage.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :address_line_1, :string
      add :address_line_2, :string
      add :county, :string
      add :postcode, :string
      add :country, :string
      add :telephone, :string
      add :email, :string
      add :website, :string

      add :organisation_id, references(:organisations)

      timestamps()
    end

  end
end
