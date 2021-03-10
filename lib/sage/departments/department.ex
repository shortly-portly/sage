defmodule Sage.Departments.Department do
  use Ecto.Schema
  import Ecto.Changeset

  schema "departments" do
    field :code, :string
    field :name, :string
    field :contact_name, :string
    field :contact_details, :string
    field :contact_email, :string

    belongs_to :company, Sage.Companies.Company

    timestamps()
  end

  @valid_attrs [:code, :name, :contact_name, :contact_details, :contact_email, :company_id]

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, @valid_attrs)
    |> validate_required([:code, :name, :company_id])
    |> validate_length(:code, max: 3)
    |> upcase_code()
  end

  defp upcase_code(changeset) do
    code = get_change(changeset, :code)

    if code do
      put_change(changeset, :code, String.upcase(code))
    else
      changeset
    end
  end
end
