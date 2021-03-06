defmodule Sage.AccountingPeriodsTest do
  use Sage.DataCase

  alias Sage.AccountingPeriods

  describe "accounting_periods" do
    alias Sage.AccountingPeriods.AccountingPeriod

    @valid_attrs %{period_no: 42}
    @update_attrs %{period_no: 43}
    @invalid_attrs %{period_no: nil}

    def accounting_period_fixture(attrs \\ %{}) do
      {:ok, accounting_period} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AccountingPeriods.create_accounting_period()

      accounting_period
    end

    test "list_accounting_periods/0 returns all accounting_periods" do
      accounting_period = accounting_period_fixture()
      assert AccountingPeriods.list_accounting_periods() == [accounting_period]
    end

    test "get_accounting_period!/1 returns the accounting_period with given id" do
      accounting_period = accounting_period_fixture()
      assert AccountingPeriods.get_accounting_period!(accounting_period.id) == accounting_period
    end

    test "create_accounting_period/1 with valid data creates a accounting_period" do
      assert {:ok, %AccountingPeriod{} = accounting_period} = AccountingPeriods.create_accounting_period(@valid_attrs)
      assert accounting_period.period_no == 42
    end

    test "create_accounting_period/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountingPeriods.create_accounting_period(@invalid_attrs)
    end

    test "update_accounting_period/2 with valid data updates the accounting_period" do
      accounting_period = accounting_period_fixture()
      assert {:ok, %AccountingPeriod{} = accounting_period} = AccountingPeriods.update_accounting_period(accounting_period, @update_attrs)
      assert accounting_period.period_no == 43
    end

    test "update_accounting_period/2 with invalid data returns error changeset" do
      accounting_period = accounting_period_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountingPeriods.update_accounting_period(accounting_period, @invalid_attrs)
      assert accounting_period == AccountingPeriods.get_accounting_period!(accounting_period.id)
    end

    test "delete_accounting_period/1 deletes the accounting_period" do
      accounting_period = accounting_period_fixture()
      assert {:ok, %AccountingPeriod{}} = AccountingPeriods.delete_accounting_period(accounting_period)
      assert_raise Ecto.NoResultsError, fn -> AccountingPeriods.get_accounting_period!(accounting_period.id) end
    end

    test "change_accounting_period/1 returns a accounting_period changeset" do
      accounting_period = accounting_period_fixture()
      assert %Ecto.Changeset{} = AccountingPeriods.change_accounting_period(accounting_period)
    end
  end
end
