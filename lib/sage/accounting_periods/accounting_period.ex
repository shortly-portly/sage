defmodule Sage.AccountingPeriods.AccountingPeriod do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounting_periods" do
    field :period_no, :integer
    field :start_date, :date
    field :end_date, :date

    belongs_to :company, Sage.Companies.Company

    timestamps()
  end

  @doc false
  def changeset(accounting_period, attrs) do
    accounting_period
    |> cast(attrs, [:period_no, :start_date, :end_date])
    |> validate_required([:period_no, :start_date, :end_date])
  end
end
