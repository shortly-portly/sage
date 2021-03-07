defmodule Sage.Fixtures do
  alias Sage.AccountingPeriods
  alias Sage.Companies
  alias Sage.Organisations

  @organisation_attrs %{name: "Organisation"}
  @company_attrs %{name: "Company"}
  @accounting_period_attrs %{period_no: 1, start_date: ~D[2021-01-01], end_date: ~D[2021-02-01]}

  @spec fixture(:organisation, any) :: any
  def fixture(entity, attrs \\ %{})

  def fixture(:organisation, attrs) do
    {:ok, organisation} =
      attrs
      |> Enum.into(@organisation_attrs)
      |> Organisations.create_organisation()

    organisation
  end

  def fixture(:company, attrs) do
    {:ok, company} =
      attrs
      |> Enum.into(@company_attrs)
      |> Companies.create_company()

    company
  end

  def fixture(:accounting_period, attrs) do
    {:ok, accounting_period} =
      attrs
      |> Enum.into(@accounting_period_attrs)
      |> AccountingPeriods.create_accounting_period()

    accounting_period
  end
end
