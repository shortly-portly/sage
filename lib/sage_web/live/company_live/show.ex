defmodule SageWeb.CompanyLive.Show do
  use SageWeb, :live_view

  alias Sage.Companies

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session, true)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:company, Companies.get_company!(id))}
  end

  defp page_title(:show), do: "Show Company"
  defp page_title(:edit), do: "Edit Company"
end
