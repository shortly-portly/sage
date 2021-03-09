defmodule SageWeb.DepartmentLive.Index do
  use SageWeb, :live_view

  alias Sage.Departments
  alias Sage.Departments.Department

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(socket, session)

    departments = list_departments()

    changesets =
      Enum.map(departments, fn department -> Departments.change_department(department) end)
      |> Enum.map(fn department ->
        department
        |> Ecto.Changeset.put_change(:temp_id, get_temp_id())
        |> Ecto.Changeset.put_change(:delete, false)
      end)

    socket =
      socket
      |> assign(:changesets, changesets)
      |> assign(:filtered, filter_changesets(changesets))

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Departments")
    |> assign(:department, %Department{})
  end

  @impl true
  def handle_event("delete", %{"temp-id" => temp_id}, socket) do
    changesets =
      Enum.map(socket.assigns.changesets, fn changeset ->
        if Ecto.Changeset.fetch_field!(changeset, :temp_id) ==
             temp_id do
          Ecto.Changeset.put_change(changeset, :delete, true)
        else
          changeset
        end
      end)

    socket =
      socket
      |> assign(:changesets, changesets)
      |> assign(:filtered, filter_changesets(changesets))

    {:noreply, socket}
  end

  @doc """
  Add a new department to the list of departments. We add it to the end of the list which
  is a bit inefficient for long lists but shouldn't be an issue in this case.
  """
  def handle_event("new", _params, socket) do
    changeset =
      %Department{}
      |> Departments.change_department()
      |> Ecto.Changeset.put_change(:temp_id, get_temp_id())
      |> Ecto.Changeset.put_change(:delete, false)

    changesets = socket.assigns.changesets ++ [changeset]

    socket =
      socket
      |> assign(:changesets, changesets)
      |> assign(:filtered, filter_changesets(changesets))

    {:noreply, socket}
  end

  def handle_event("validate", %{"department" => department_params}, socket) do
    IO.inspect(department_params)

    new_changeset =
      %Department{delete: false}
      |> Departments.change_department(department_params)
      |> Map.put(:action, :validate)
      |> IO.inspect()

    IO.inspect(new_changeset.data)

    changesets =
      Enum.map(socket.assigns.changesets, fn changeset ->
        if Ecto.Changeset.fetch_field!(changeset, :temp_id) ==
             Ecto.Changeset.fetch_field!(new_changeset, :temp_id) do
          new_changeset
        else
          changeset
        end
      end)

    socket =
      socket
      |> assign(:changesets, changesets)
      |> assign(:filtered, filter_changesets(changesets))

    {:noreply, socket}
  end

  defp list_departments do
    Departments.list_departments()
  end

  defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)

  defp filter_changesets(changesets) do
    Enum.filter(changesets, fn changeset ->
      Ecto.Changeset.fetch_field!(changeset, :delete) == false
    end)
  end
end
