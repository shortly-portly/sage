defmodule Sage.Fixtures do
  alias Sage.Companies
  alias Sage.Organisations

  @organisation_attrs %{name: "Organisation"}
  @company_attrs %{name: "Company"}

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
end
