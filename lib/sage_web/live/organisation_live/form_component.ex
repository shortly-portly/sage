defmodule SageWeb.OrganisationLive.FormComponent do
  use SageWeb, :live_component

  alias Sage.Organisations

  @impl true
  def update(%{organisation: organisation} = assigns, socket) do
    changeset = Organisations.change_organisation(organisation)
    # countries = Poison.encode!(%{fr: "France"}, %{en: "Eng"})
    countries = %{fr: "France", en: "Eng"}
    countries = Jason.encode!(countries)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:countries, countries)}
  end

  @impl true
  def handle_event("validate", %{"organisation" => organisation_params}, socket) do
    changeset =
      socket.assigns.organisation
      |> Organisations.change_organisation(organisation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"organisation" => organisation_params} = params, socket) do
    save_organisation(socket, socket.assigns.action, organisation_params)
  end

  defp save_organisation(socket, :edit, organisation_params) do
    case Organisations.update_organisation(socket.assigns.organisation, organisation_params) do
      {:ok, _organisation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Organisation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
