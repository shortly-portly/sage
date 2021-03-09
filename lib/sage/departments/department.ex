defmodule Sage.Departments.Department do
  use Ecto.Schema
  import Ecto.Changeset

  schema "departments" do
    field :code, :string
    field :name, :string
    field :contact_name, :string
    field :contact_details, :string
    field :contact_email, :string

    field :temp_id, :string, virtual: true
    field :delete, :boolean, virtual: true

    timestamps()
  end

  @valid_attrs [:code, :name, :contact_name, :contact_details, :contact_email, :temp_id]

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, @valid_attrs)
    |> validate_required([:code, :name])
  end
end
