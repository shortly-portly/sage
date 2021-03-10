defmodule SageWeb.CostCentreLive.FormComponent do
  use SageWeb, :live_component

  alias Sage.CostCentres

  @impl true
  def update(%{cost_centre: cost_centre} = assigns, socket) do
    changeset = CostCentres.change_cost_centre(cost_centre)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cost_centre" => cost_centre_params}, socket) do
    changeset =
      socket.assigns.cost_centre
      |> CostCentres.change_cost_centre(cost_centre_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cost_centre" => cost_centre_params}, socket) do
    save_cost_centre(socket, socket.assigns.action, cost_centre_params)
  end

  defp save_cost_centre(socket, :edit, cost_centre_params) do
    case CostCentres.update_cost_centre(socket.assigns.cost_centre, cost_centre_params) do
      {:ok, _cost_centre} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cost centre updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cost_centre(socket, :new, cost_centre_params) do
    IO.inspect(socket.assigns, label: "COMPANY ID")
    cost_centre_params = Map.put(cost_centre_params, "company_id", socket.assigns.company_id)

    case CostCentres.create_cost_centre(cost_centre_params) do
      {:ok, _cost_centre} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cost centre created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
