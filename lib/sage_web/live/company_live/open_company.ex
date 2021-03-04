defmodule SageWeb.CompanyLive.OpenCompany do
  use SageWeb, :live_view

  alias Sage.Companies

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> PhoenixLiveSession.maybe_subscribe(session)
      |> assign_defaults(session)

    companies = list_companies(socket.assigns)

    socket =
      socket
      |> assign(:companies, companies)
      |> assign(:filtered, companies)

    {:ok, socket}
  end

  @impl true
  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, socket}
  end

  @impl true
  @spec handle_params(any, any, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}

  def handle_event("filter", %{"value" => value}, socket) do
    filtered =
      Enum.filter(socket.assigns.companies, fn company ->
        String.starts_with?(company.name, value)
      end)

    {:noreply, assign(socket, :filtered, filtered)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :open, %{"id" => id}) do
    if socket.connected? do
      PhoenixLiveSession.put_session(socket, "company_id", id)
    end

    socket
    |> assign(:company, Companies.get_company!(id))

    redirect(socket, to: Routes.page_path(socket, :index))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Companies")
    |> assign(:company, nil)
  end

  defp list_companies(assigns) do
    Companies.list_companies(assigns.current_user.organisation_id)
  end
end
