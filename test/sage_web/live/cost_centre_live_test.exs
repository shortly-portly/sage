defmodule SageWeb.CostCentreLiveTest do
  use SageWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Sage.CostCentres

  @create_attrs %{code: "some code"}
  @update_attrs %{code: "some updated code"}
  @invalid_attrs %{code: nil}

  defp fixture(:cost_centre) do
    {:ok, cost_centre} = CostCentres.create_cost_centre(@create_attrs)
    cost_centre
  end

  defp create_cost_centre(_) do
    cost_centre = fixture(:cost_centre)
    %{cost_centre: cost_centre}
  end

  describe "Index" do
    setup [:create_cost_centre]

    test "lists all cost_centres", %{conn: conn, cost_centre: cost_centre} do
      {:ok, _index_live, html} = live(conn, Routes.cost_centre_index_path(conn, :index))

      assert html =~ "Listing Cost centres"
      assert html =~ cost_centre.code
    end

    test "saves new cost_centre", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.cost_centre_index_path(conn, :index))

      assert index_live |> element("a", "New Cost centre") |> render_click() =~
               "New Cost centre"

      assert_patch(index_live, Routes.cost_centre_index_path(conn, :new))

      assert index_live
             |> form("#cost_centre-form", cost_centre: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cost_centre-form", cost_centre: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cost_centre_index_path(conn, :index))

      assert html =~ "Cost centre created successfully"
      assert html =~ "some code"
    end

    test "updates cost_centre in listing", %{conn: conn, cost_centre: cost_centre} do
      {:ok, index_live, _html} = live(conn, Routes.cost_centre_index_path(conn, :index))

      assert index_live |> element("#cost_centre-#{cost_centre.id} a", "Edit") |> render_click() =~
               "Edit Cost centre"

      assert_patch(index_live, Routes.cost_centre_index_path(conn, :edit, cost_centre))

      assert index_live
             |> form("#cost_centre-form", cost_centre: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cost_centre-form", cost_centre: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cost_centre_index_path(conn, :index))

      assert html =~ "Cost centre updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes cost_centre in listing", %{conn: conn, cost_centre: cost_centre} do
      {:ok, index_live, _html} = live(conn, Routes.cost_centre_index_path(conn, :index))

      assert index_live |> element("#cost_centre-#{cost_centre.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cost_centre-#{cost_centre.id}")
    end
  end

  describe "Show" do
    setup [:create_cost_centre]

    test "displays cost_centre", %{conn: conn, cost_centre: cost_centre} do
      {:ok, _show_live, html} = live(conn, Routes.cost_centre_show_path(conn, :show, cost_centre))

      assert html =~ "Show Cost centre"
      assert html =~ cost_centre.code
    end

    test "updates cost_centre within modal", %{conn: conn, cost_centre: cost_centre} do
      {:ok, show_live, _html} = live(conn, Routes.cost_centre_show_path(conn, :show, cost_centre))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cost centre"

      assert_patch(show_live, Routes.cost_centre_show_path(conn, :edit, cost_centre))

      assert show_live
             |> form("#cost_centre-form", cost_centre: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cost_centre-form", cost_centre: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cost_centre_show_path(conn, :show, cost_centre))

      assert html =~ "Cost centre updated successfully"
      assert html =~ "some updated code"
    end
  end
end
