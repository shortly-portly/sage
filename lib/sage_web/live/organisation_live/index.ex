defmodule SageWeb.OrganisationLive.Index do
  use SageWeb, :live_view

  alias Sage.Organisations
  alias Sage.Organisations.Organisation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :organisations, list_organisations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Organisation")
    |> assign(:organisation, Organisations.get_organisation!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Organisations")
    |> assign(:organisation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    organisation = Organisations.get_organisation!(id)
    {:ok, _} = Organisations.delete_organisation(organisation)

    {:noreply, assign(socket, :organisations, list_organisations())}
  end

  defp list_organisations do
    Organisations.list_organisations()
  end
end
