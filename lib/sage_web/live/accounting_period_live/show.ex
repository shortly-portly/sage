defmodule SageWeb.AccountingPeriodLive.Show do
  use SageWeb, :live_view

  alias Sage.AccountingPeriods

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:accounting_period, AccountingPeriods.get_accounting_period!(id))}
  end

  defp page_title(:show), do: "Show Accounting period"
  defp page_title(:edit), do: "Edit Accounting period"
end
