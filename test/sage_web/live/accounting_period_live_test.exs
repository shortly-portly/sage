defmodule SageWeb.AccountingPeriodLiveTest do
  use SageWeb.ConnCase

  import Phoenix.LiveViewTest
  import Sage.AccountsFixtures
  import Sage.Fixtures

  @create_attrs %{period_no: 42, start_date: ~D[2021-03-03], end_date: ~D[2021-03-22]}
  @update_attrs %{period_no: 43}
  @invalid_attrs %{period_no: nil}

  describe "Index" do
    setup %{conn: conn} do
      user = organisation_fixture(%{organisation: %{name: "Organisation"}})
      accounting_period = fixture(:accounting_period, %{organisation_id: user.organisation.id})

      conn = log_in_user(conn, user)

      %{conn: conn, organisation: user.organisation, accounting_period: accounting_period}
    end

    test "lists all accounting_periods", %{conn: conn, accounting_period: _accounting_period} do
      {:ok, _index_live, html} = live(conn, Routes.accounting_period_index_path(conn, :index))

      assert html =~ "Listing Accounting periods"
    end

    test "saves new accounting_period", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.accounting_period_index_path(conn, :index))

      assert index_live |> element("a", "New Accounting period") |> render_click() =~
               "New Accounting period"

      assert_patch(index_live, Routes.accounting_period_index_path(conn, :new))

      assert index_live
             |> form("#accounting_period-form", accounting_period: @invalid_attrs)
             |> render_change() =~ "be blank"

      {:ok, _, html} =
        index_live
        |> form("#accounting_period-form", accounting_period: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.accounting_period_index_path(conn, :index))

      assert html =~ "Accounting period created successfully"
    end

    test "updates accounting_period in listing", %{
      conn: conn,
      accounting_period: accounting_period
    } do
      {:ok, index_live, _html} = live(conn, Routes.accounting_period_index_path(conn, :index))

      assert index_live
             |> element("#accounting_period-#{accounting_period.id} a", "Edit")
             |> render_click() =~
               "Edit Accounting period"

      assert_patch(
        index_live,
        Routes.accounting_period_index_path(conn, :edit, accounting_period)
      )

      assert index_live
             |> form("#accounting_period-form", accounting_period: @invalid_attrs)
             |> render_change() =~ "be blank"

      {:ok, _, html} =
        index_live
        |> form("#accounting_period-form", accounting_period: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.accounting_period_index_path(conn, :index))

      assert html =~ "Accounting period updated successfully"
    end

    test "deletes accounting_period in listing", %{
      conn: conn,
      accounting_period: accounting_period
    } do
      {:ok, index_live, _html} = live(conn, Routes.accounting_period_index_path(conn, :index))

      assert index_live
             |> element("#accounting_period-#{accounting_period.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#accounting_period-#{accounting_period.id}")
    end
  end

  describe "Show" do
    setup %{conn: conn} do
      user = organisation_fixture(%{organisation: %{name: "Organisation"}})
      accounting_period = fixture(:accounting_period, %{organisation_id: user.organisation.id})

      conn = log_in_user(conn, user)

      %{conn: conn, organisation: user.organisation, accounting_period: accounting_period}
    end

    test "displays accounting_period", %{conn: conn, accounting_period: accounting_period} do
      {:ok, _show_live, html} =
        live(conn, Routes.accounting_period_show_path(conn, :show, accounting_period))

      assert html =~ "Show Accounting period"
    end

    test "updates accounting_period within modal", %{
      conn: conn,
      accounting_period: accounting_period
    } do
      {:ok, show_live, _html} =
        live(conn, Routes.accounting_period_show_path(conn, :show, accounting_period))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Accounting period"

      assert_patch(show_live, Routes.accounting_period_show_path(conn, :edit, accounting_period))

      assert show_live
             |> form("#accounting_period-form", accounting_period: @invalid_attrs)
             |> render_change() =~ "be blank"

      {:ok, _, html} =
        show_live
        |> form("#accounting_period-form", accounting_period: @update_attrs)
        |> render_submit()
        |> follow_redirect(
          conn,
          Routes.accounting_period_show_path(conn, :show, accounting_period)
        )

      assert html =~ "Accounting period updated successfully"
    end
  end
end
