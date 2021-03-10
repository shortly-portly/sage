defmodule Sage.Repo.Migrations.CreateCostCentres do
  use Ecto.Migration

  def change do
    create table(:cost_centres) do
      add :code, :string
      add :name, :string
      add :contact_name, :string
      add :contact_details, :string
      add :contact_email, :string

      add :company_id, references(:companies)

      timestamps()
    end

    create unique_index(:cost_centres, [:code, :company_id])

  end
end
