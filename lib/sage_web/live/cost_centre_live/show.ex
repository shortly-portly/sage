defmodule SageWeb.CostCentreLive.Show do
  use SageWeb, :live_view

  alias Sage.CostCentres

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cost_centre, CostCentres.get_cost_centre!(id))}
  end

  defp page_title(:show), do: "Show Cost centre"
  defp page_title(:edit), do: "Edit Cost centre"
end
