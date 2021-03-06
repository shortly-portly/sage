defmodule Sage.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias Sage.Repo

  alias Sage.Companies.Company
  alias Sage.AccountingPeriods.AccountingPeriod

  @doc """
  Returns the list of companies associated with the given organisation id.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies(organisation_id) do
    from(
      c in Company,
      where: c.organisation_id == ^organisation_id,
      preload: [:accounting_periods]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """

  # comments_query = from c in Comment, order_by: c.published_at
  # Repo.all from p in Post, preload: [comments: ^comments_query]

  def get_company!(id) do
    query = from ap in AccountingPeriod, order_by: ap.period_no

    Repo.one!(
      from c in Company,
        where: c.id == ^id,
        preload: [accounting_periods: ^query]
    )
  end

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end

  @doc """
  Returns a company struct pre-populated with defaults for a new company.
  """
  def company_defaults do
    today = Date.utc_today()

    %Company{}
    |> Map.put(:financial_month_start, today.month)
    |> Map.put(:financial_year_start, today.year)
    |> Map.put(:accounting_periods, default_accounting_periods(today))
  end

  def default_accounting_periods(date) do
    Enum.map(0..11, fn period ->
      %AccountingPeriod{}
      |> Map.put(:period_no, period + 1)
      |> Map.put(:start_date, Timex.beginning_of_month(Timex.shift(date, months: period)))
      |> Map.put(:end_date, Timex.end_of_month(Timex.shift(date, months: period)))
    end)
  end
end
