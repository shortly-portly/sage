defmodule SageWeb.AccountingPeriodLive.Index do
  use SageWeb, :live_view

  alias Sage.AccountingPeriods
  alias Sage.AccountingPeriods.AccountingPeriod

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :accounting_periods, list_accounting_periods())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Accounting period")
    |> assign(:accounting_period, AccountingPeriods.get_accounting_period!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Accounting period")
    |> assign(:accounting_period, %AccountingPeriod{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Accounting periods")
    |> assign(:accounting_period, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    accounting_period = AccountingPeriods.get_accounting_period!(id)
    {:ok, _} = AccountingPeriods.delete_accounting_period(accounting_period)

    {:noreply, assign(socket, :accounting_periods, list_accounting_periods())}
  end

  defp list_accounting_periods do
    AccountingPeriods.list_accounting_periods()
  end
end
