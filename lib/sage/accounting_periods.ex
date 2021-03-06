defmodule Sage.AccountingPeriods do
  @moduledoc """
  The AccountingPeriods context.
  """

  import Ecto.Query, warn: false
  alias Sage.Repo

  alias Sage.AccountingPeriods.AccountingPeriod

  @doc """
  Returns the list of accounting_periods.

  ## Examples

      iex> list_accounting_periods()
      [%AccountingPeriod{}, ...]

  """
  def list_accounting_periods do
    Repo.all(AccountingPeriod)
  end

  @doc """
  Gets a single accounting_period.

  Raises `Ecto.NoResultsError` if the Accounting period does not exist.

  ## Examples

      iex> get_accounting_period!(123)
      %AccountingPeriod{}

      iex> get_accounting_period!(456)
      ** (Ecto.NoResultsError)

  """
  def get_accounting_period!(id), do: Repo.get!(AccountingPeriod, id)

  @doc """
  Creates a accounting_period.

  ## Examples

      iex> create_accounting_period(%{field: value})
      {:ok, %AccountingPeriod{}}

      iex> create_accounting_period(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_accounting_period(attrs \\ %{}) do
    %AccountingPeriod{}
    |> AccountingPeriod.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a accounting_period.

  ## Examples

      iex> update_accounting_period(accounting_period, %{field: new_value})
      {:ok, %AccountingPeriod{}}

      iex> update_accounting_period(accounting_period, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_accounting_period(%AccountingPeriod{} = accounting_period, attrs) do
    accounting_period
    |> AccountingPeriod.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a accounting_period.

  ## Examples

      iex> delete_accounting_period(accounting_period)
      {:ok, %AccountingPeriod{}}

      iex> delete_accounting_period(accounting_period)
      {:error, %Ecto.Changeset{}}

  """
  def delete_accounting_period(%AccountingPeriod{} = accounting_period) do
    Repo.delete(accounting_period)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking accounting_period changes.

  ## Examples

      iex> change_accounting_period(accounting_period)
      %Ecto.Changeset{data: %AccountingPeriod{}}

  """
  def change_accounting_period(%AccountingPeriod{} = accounting_period, attrs \\ %{}) do
    AccountingPeriod.changeset(accounting_period, attrs)
  end
end
