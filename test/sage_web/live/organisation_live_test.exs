defmodule SageWeb.OrganisationLiveTest do
  use SageWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Sage.Organisations

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:organisation) do
    {:ok, organisation} = Organisations.create_organisation(@create_attrs)
    organisation
  end

  defp create_organisation(_) do
    organisation = fixture(:organisation)
    %{organisation: organisation}
  end

  describe "Index" do
    setup [:create_organisation]

    test "lists all organisations", %{conn: conn, organisation: organisation} do
      {:ok, _index_live, html} = live(conn, Routes.organisation_index_path(conn, :index))

      assert html =~ "Listing Organisations"
      assert html =~ organisation.name
    end

    test "updates organisation in listing", %{conn: conn, organisation: organisation} do
      {:ok, index_live, _html} = live(conn, Routes.organisation_index_path(conn, :index))

      assert index_live |> element("#organisation-#{organisation.id} a", "Edit") |> render_click() =~
               "Edit #{organisation.name}"

      assert_patch(index_live, Routes.organisation_index_path(conn, :edit, organisation))

      assert index_live
             |> form("#organisation-form", organisation: @invalid_attrs)
             |> render_change() =~ "be blank"

      {:ok, _, html} =
        index_live
        |> form("#organisation-form", organisation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.organisation_index_path(conn, :index))

      assert html =~ "Organisation updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes organisation in listing", %{conn: conn, organisation: organisation} do
      {:ok, index_live, _html} = live(conn, Routes.organisation_index_path(conn, :index))

      assert index_live
             |> element("#organisation-#{organisation.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#organisation-#{organisation.id}")
    end
  end

  describe "Show" do
    setup [:create_organisation]

    test "displays organisation", %{conn: conn, organisation: organisation} do
      {:ok, _show_live, html} =
        live(conn, Routes.organisation_show_path(conn, :show, organisation))

      assert html =~ "Show Organisation"
      assert html =~ organisation.name
    end

    test "updates organisation within modal", %{conn: conn, organisation: organisation} do
      {:ok, show_live, _html} =
        live(conn, Routes.organisation_show_path(conn, :show, organisation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Organisation"

      assert_patch(show_live, Routes.organisation_show_path(conn, :edit, organisation))

      assert show_live
             |> form("#organisation-form", organisation: @invalid_attrs)
             |> render_change() =~ "be blank"

      {:ok, _, html} =
        show_live
        |> form("#organisation-form", organisation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.organisation_show_path(conn, :show, organisation))

      assert html =~ "Organisation updated successfully"
      assert html =~ "some updated name"
    end
  end
end
