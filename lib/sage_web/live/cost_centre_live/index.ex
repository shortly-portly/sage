defmodule SageWeb.CostCentreLive.Index do
  use SageWeb, :live_view

  alias Sage.CostCentres
  alias Sage.CostCentres.CostCentre

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session)

    {:ok, assign(socket, :cost_centres, list_cost_centres())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cost centre")
    |> assign(:cost_centre, CostCentres.get_cost_centre!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cost centre")
    |> assign(:cost_centre, %CostCentre{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cost centres")
    |> assign(:cost_centre, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cost_centre = CostCentres.get_cost_centre!(id)
    {:ok, _} = CostCentres.delete_cost_centre(cost_centre)

    {:noreply, assign(socket, :cost_centres, list_cost_centres())}
  end

  defp list_cost_centres do
    CostCentres.list_cost_centres()
  end
end
