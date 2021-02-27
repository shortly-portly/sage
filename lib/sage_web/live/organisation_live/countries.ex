defmodule SageWeb.OrganisationLive.CountriesComponent do
  use Phoenix.LiveComponent

  @impl true
  def update(assigns, socket) do
    countries = %{fr: "France", en: "Eng"}
    countries = Jason.encode!(countries)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:countries, countries)}
  end
end
