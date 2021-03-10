defmodule SageWeb.CompanyLive.Index do
  use SageWeb, :live_view

  alias Sage.Companies
  alias Sage.Companies.Company
  alias Sage.AccountingPeriods.AccountingPeriod

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session, true)

    {:ok, assign(socket, :companies, list_companies(socket.assigns))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Company")
    |> assign(:company, Companies.get_company!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Company")
    |> assign(:company, Companies.company_defaults())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Companies")
    |> assign(:company, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    company = Companies.get_company!(id)
    {:ok, _} = Companies.delete_company(company)

    {:noreply, assign(socket, :companies, list_companies(socket.assigns))}
  end

  defp list_companies(assigns) do
    Companies.list_companies(assigns.current_user.organisation_id)
  end
end
