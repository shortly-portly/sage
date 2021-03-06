defmodule SageWeb.AccountingPeriodLive.FormComponent do
  use SageWeb, :live_component

  alias Sage.AccountingPeriods

  @impl true
  def update(%{accounting_period: accounting_period} = assigns, socket) do
    changeset = AccountingPeriods.change_accounting_period(accounting_period)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"accounting_period" => accounting_period_params}, socket) do
    changeset =
      socket.assigns.accounting_period
      |> AccountingPeriods.change_accounting_period(accounting_period_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"accounting_period" => accounting_period_params}, socket) do
    save_accounting_period(socket, socket.assigns.action, accounting_period_params)
  end

  defp save_accounting_period(socket, :edit, accounting_period_params) do
    case AccountingPeriods.update_accounting_period(socket.assigns.accounting_period, accounting_period_params) do
      {:ok, _accounting_period} ->
        {:noreply,
         socket
         |> put_flash(:info, "Accounting period updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_accounting_period(socket, :new, accounting_period_params) do
    case AccountingPeriods.create_accounting_period(accounting_period_params) do
      {:ok, _accounting_period} ->
        {:noreply,
         socket
         |> put_flash(:info, "Accounting period created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
