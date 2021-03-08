defmodule Sage.Repo.Migrations.CreateDepartments do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :code, :string
      add :name, :string
      add :contact_name, :string
      add :contact_details, :string
      add :contact_email, :string

      timestamps()
    end

  end
end
