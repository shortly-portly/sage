defmodule SageWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  import Phoenix.LiveView

  alias SageWeb.Router.Helpers, as: Routes
  alias Sage.Accounts

  @doc """
  Renders a component inside the `SageWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, SageWeb.OrganisationLive.FormComponent,
        id: @organisation.id || :new,
        action: @live_action,
        organisation: @organisation,
        return_to: Routes.organisation_index_path(@socket, :index) %>
  """
  def live_modal(_socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, SageWeb.ModalComponent, modal_opts)
  end

  def assign_defaults(socket, session, skip_company_check \\ false) do
    socket =
      socket
      |> assign_new(:current_user, fn ->
        Accounts.get_user_by_session_token(session["user_token"])
      end)
      |> assign_new(:company_id, fn -> Map.get(session, "company_id", nil) end)

    if socket.assigns.current_user do
      if skip_company_check == true || socket.assigns.company_id do
        socket
      else
        redirect(socket, to: Routes.company_open_company_path(socket, :index))
      end
    else
      redirect(socket, to: Routes.user_session_path(socket, :new))
    end
  end
end
