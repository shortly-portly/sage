defmodule SageWeb.CompanyLive.FormComponent do
  use SageWeb, :live_component

  alias Sage.Companies
  alias Sage.Companies.Company

  @months [
    Jan: 1,
    Feb: 2,
    Mar: 3,
    Apr: 4,
    May: 5,
    Jun: 6,
    Jul: 7,
    Aug: 8,
    Sep: 9,
    Oct: 10,
    Nov: 11,
    Dec: 12
  ]

  @impl true
  def update(%{company: company} = assigns, socket) do
    changeset = Companies.change_company(company)

    today = Date.utc_today().year
    years = (today - 5)..(today + 5)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:months, @months)
     |> assign(:years, years)}
  end

  @impl true
  def handle_event("validate", %{"company" => company_params}, socket) do
    company =
      if socket.assigns.action == :new do
        %Company{}
      else
        socket.assigns.company
      end

    changeset =
      company
      |> Companies.change_company(company_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"company" => company_params}, socket) do
    save_company(socket, socket.assigns.action, company_params)
  end

  defp save_company(socket, :edit, company_params) do
    case Companies.update_company(socket.assigns.company, company_params) do
      {:ok, _company} ->
        {:noreply,
         socket
         |> put_flash(:info, "Company updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_company(socket, :new, company_params) do
    company_params =
      Map.put(company_params, "organisation_id", socket.assigns.current_user.organisation_id)

    case Companies.create_company(company_params) do
      {:ok, _company} ->
        {:noreply,
         socket
         |> put_flash(:info, "Company created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
