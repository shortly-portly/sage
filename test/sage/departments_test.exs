defmodule Sage.DepartmentsTest do
  use Sage.DataCase

  alias Sage.Departments

  describe "departments" do
    alias Sage.Departments.Department

    @valid_attrs %{code: "some code"}
    @update_attrs %{code: "some updated code"}
    @invalid_attrs %{code: nil}

    def department_fixture(attrs \\ %{}) do
      {:ok, department} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Departments.create_department()

      department
    end

    test "list_departments/0 returns all departments" do
      department = department_fixture()
      assert Departments.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      department = department_fixture()
      assert Departments.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      assert {:ok, %Department{} = department} = Departments.create_department(@valid_attrs)
      assert department.code == "some code"
    end

    test "create_department/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Departments.create_department(@invalid_attrs)
    end

    test "update_department/2 with valid data updates the department" do
      department = department_fixture()
      assert {:ok, %Department{} = department} = Departments.update_department(department, @update_attrs)
      assert department.code == "some updated code"
    end

    test "update_department/2 with invalid data returns error changeset" do
      department = department_fixture()
      assert {:error, %Ecto.Changeset{}} = Departments.update_department(department, @invalid_attrs)
      assert department == Departments.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      department = department_fixture()
      assert {:ok, %Department{}} = Departments.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> Departments.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      department = department_fixture()
      assert %Ecto.Changeset{} = Departments.change_department(department)
    end
  end
end
