defmodule Sage.CostCentresTest do
  use Sage.DataCase

  alias Sage.CostCentres

  describe "cost_centres" do
    alias Sage.CostCentres.CostCentre

    @valid_attrs %{code: "some code"}
    @update_attrs %{code: "some updated code"}
    @invalid_attrs %{code: nil}

    def cost_centre_fixture(attrs \\ %{}) do
      {:ok, cost_centre} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CostCentres.create_cost_centre()

      cost_centre
    end

    test "list_cost_centres/0 returns all cost_centres" do
      cost_centre = cost_centre_fixture()
      assert CostCentres.list_cost_centres() == [cost_centre]
    end

    test "get_cost_centre!/1 returns the cost_centre with given id" do
      cost_centre = cost_centre_fixture()
      assert CostCentres.get_cost_centre!(cost_centre.id) == cost_centre
    end

    test "create_cost_centre/1 with valid data creates a cost_centre" do
      assert {:ok, %CostCentre{} = cost_centre} = CostCentres.create_cost_centre(@valid_attrs)
      assert cost_centre.code == "some code"
    end

    test "create_cost_centre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CostCentres.create_cost_centre(@invalid_attrs)
    end

    test "update_cost_centre/2 with valid data updates the cost_centre" do
      cost_centre = cost_centre_fixture()
      assert {:ok, %CostCentre{} = cost_centre} = CostCentres.update_cost_centre(cost_centre, @update_attrs)
      assert cost_centre.code == "some updated code"
    end

    test "update_cost_centre/2 with invalid data returns error changeset" do
      cost_centre = cost_centre_fixture()
      assert {:error, %Ecto.Changeset{}} = CostCentres.update_cost_centre(cost_centre, @invalid_attrs)
      assert cost_centre == CostCentres.get_cost_centre!(cost_centre.id)
    end

    test "delete_cost_centre/1 deletes the cost_centre" do
      cost_centre = cost_centre_fixture()
      assert {:ok, %CostCentre{}} = CostCentres.delete_cost_centre(cost_centre)
      assert_raise Ecto.NoResultsError, fn -> CostCentres.get_cost_centre!(cost_centre.id) end
    end

    test "change_cost_centre/1 returns a cost_centre changeset" do
      cost_centre = cost_centre_fixture()
      assert %Ecto.Changeset{} = CostCentres.change_cost_centre(cost_centre)
    end
  end
end
