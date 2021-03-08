defmodule SageWeb.DepartmentLive.FormComponent do
  use SageWeb, :live_component

  alias Sage.Departments

  @impl true
  def update(%{department: department} = assigns, socket) do
    # Update will be called in two scenarios. Initially with a department passed as part of the assigs from the parent.
    # However it will also be called when a new department is added when the parent iterates theough the list of
    # departments and calls this form component. In the second case we may have made changes to this department which
    # haven't been persisted to the database. In this case we want to pick up the department information from
    # the components assigns.

    changeset =
      if Map.has_key?(socket.assigns, :changeset) do
        socket.assigns.changeset
      else
        Departments.change_department(department)
      end

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"department" => department_params}, socket) do
    changeset =
      socket.assigns.department
      |> Departments.change_department(department_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"department" => department_params}, socket) do
    save_department(socket, socket.assigns.action, department_params)
  end

  defp save_department(socket, :edit, department_params) do
    case Departments.update_department(socket.assigns.department, department_params) do
      {:ok, _department} ->
        {:noreply,
         socket
         |> put_flash(:info, "Department updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_department(socket, :new, department_params) do
    case Departments.create_department(department_params) do
      {:ok, _department} ->
        {:noreply,
         socket
         |> put_flash(:info, "Department created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
