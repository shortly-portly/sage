defmodule Sage.CostCentres do
  @moduledoc """
  The CostCentres context.
  """

  import Ecto.Query, warn: false
  alias Sage.Repo

  alias Sage.CostCentres.CostCentre

  @doc """
  Returns the list of cost_centres.

  ## Examples

      iex> list_cost_centres()
      [%CostCentre{}, ...]

  """
  def list_cost_centres do
    Repo.all(CostCentre)
  end

  @doc """
  Gets a single cost_centre.

  Raises `Ecto.NoResultsError` if the Cost centre does not exist.

  ## Examples

      iex> get_cost_centre!(123)
      %CostCentre{}

      iex> get_cost_centre!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cost_centre!(id), do: Repo.get!(CostCentre, id)

  @doc """
  Creates a cost_centre.

  ## Examples

      iex> create_cost_centre(%{field: value})
      {:ok, %CostCentre{}}

      iex> create_cost_centre(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cost_centre(attrs \\ %{}) do
    %CostCentre{}
    |> CostCentre.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cost_centre.

  ## Examples

      iex> update_cost_centre(cost_centre, %{field: new_value})
      {:ok, %CostCentre{}}

      iex> update_cost_centre(cost_centre, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cost_centre(%CostCentre{} = cost_centre, attrs) do
    cost_centre
    |> CostCentre.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cost_centre.

  ## Examples

      iex> delete_cost_centre(cost_centre)
      {:ok, %CostCentre{}}

      iex> delete_cost_centre(cost_centre)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cost_centre(%CostCentre{} = cost_centre) do
    Repo.delete(cost_centre)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cost_centre changes.

  ## Examples

      iex> change_cost_centre(cost_centre)
      %Ecto.Changeset{data: %CostCentre{}}

  """
  def change_cost_centre(%CostCentre{} = cost_centre, attrs \\ %{}) do
    CostCentre.changeset(cost_centre, attrs)
  end
end
