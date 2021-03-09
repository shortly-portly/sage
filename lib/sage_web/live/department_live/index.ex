defmodule SageWeb.DepartmentLive.Index do
  use SageWeb, :live_view

  alias Sage.Departments
  alias Sage.Departments.Department

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session)

    departments = list_departments()

    changesets =
      Enum.map(departments, fn department ->
        Map.put(department, :temp_id, get_temp_id())
      end)
      |> Enum.map(fn department -> Departments.change_department(department) end)

    {:ok, assign(socket, :changesets, changesets)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Department")
    |> assign(:department, Departments.get_department!(id))
  end

  defp apply_action(socket, :new, _params) do
    # Add a new department to the list of departments. We add it to the end of the list which
    # is a bit inefficient for long lists but shouldn't be an issue in this case.
    departments = socket.assigns.departments ++ [%Department{temp_id: get_temp_id()}]

    socket
    |> assign(:departments, departments)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Departments")
    |> assign(:department, %Department{})
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    department = Departments.get_department!(id)
    {:ok, _} = Departments.delete_department(department)

    {:noreply, assign(socket, :departments, list_departments())}
  end

  def handle_event("new", _params, socket) do
    IO.puts("New called")

    changeset =
      %Department{}
      |> Map.put(:temp_id, get_temp_id())
      |> Departments.change_department()

    changesets = socket.assigns.changesets ++ [changeset]

    {:noreply, assign(socket, :changesets, changesets)}
  end

  def handle_event("validate", %{"department" => department_params}, socket) do
    # new_changeset = Departments.change_department(%Department{}, department_params)

    new_changeset =
      %Department{}
      |> Departments.change_department(department_params)
      |> Map.put(:action, :validate2)

    changesets =
      Enum.map(socket.assigns.changesets, fn changeset ->
        if Ecto.Changeset.fetch_field!(changeset, :temp_id) ==
             Ecto.Changeset.fetch_field!(new_changeset, :temp_id) do
          new_changeset
        else
          changeset
        end
      end)

    {:noreply, assign(socket, :changesets, changesets)}
  end

  defp list_departments do
    Departments.list_departments()
  end

  defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)
end
