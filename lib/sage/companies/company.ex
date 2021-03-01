defmodule Sage.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

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

    belongs_to :organisation, Sage.Organisations.Organisation

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
    :organisation_id
  ]
  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, @valid_attrs)
    |> validate_required([:name, :organisation_id])
  end
end
