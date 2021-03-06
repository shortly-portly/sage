defmodule Sage.Repo.Migrations.CreateAccountingPeriods do
  use Ecto.Migration

  def change do
    create table(:accounting_periods) do
      add :period_no, :integer
      add :start_date, :date
      add :end_date, :date
      add :company_id, references(:companies)

      timestamps()
    end

  end
end
