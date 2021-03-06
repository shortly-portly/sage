defmodule Sage.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Sage.Companies

  schema "companies" do
    field :name, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :county, :string
    field :postcode, :string
    field :country, :string
    field :telephone, :string
    field :email, :string
    field :website, :string

    field :vat_registration_number, :string
    field :vat_country_code, :string
    field :next_vat_return_date, :date
    field :eori_number, :string
    field :financial_year_start, :integer
    field :financial_month_start, :integer

    belongs_to :organisation, Sage.Organisations.Organisation
    has_many :accounting_periods, Sage.AccountingPeriods.AccountingPeriod

    timestamps()
  end

  @valid_attrs [
    :name,
    :address_line_1,
    :address_line_2,
    :county,
    :postcode,
    :country,
    :telephone,
    :email,
    :website,
    :organisation_id,
    :vat_registration_number,
    :vat_country_code,
    :next_vat_return_date,
    :eori_number,
    :financial_month_start,
    :financial_year_start
  ]

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, @valid_attrs)
    |> validate_required([:name, :organisation_id])
    |> cast_assoc(:accounting_periods)
    |> set_accounting_periods
  end

  # If either the financial start year or month have changed then we need to recalculate
  # the default accounting periods.
  defp set_accounting_periods(changeset) do
    year = get_change(changeset, :financial_year_start)
    month = get_change(changeset, :financial_month_end)

    if year || month do
      year = get_field(changeset, :financial_year_start)
      month = get_field(changeset, :financial_month_start)
      date = Timex.to_date({year, month, 01})
      accounting_periods = Companies.default_accounting_periods(date)
      put_change(changeset, :accounting_periods, accounting_periods)
    else
      changeset
    end
  end
end
