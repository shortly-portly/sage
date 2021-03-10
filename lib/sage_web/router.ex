defmodule SageWeb.Router do
  use SageWeb, :router

  import SageWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SageWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SageWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SageWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SageWeb.Telemetry, ecto_repos: [Sage.Repo]
    end
  end

  ## Authentication routes

  scope "/", SageWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", SageWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live "/companies", CompanyLive.Index, :index
    live "/companies/new", CompanyLive.Index, :new
    live "/companies/:id/edit", CompanyLive.Index, :edit

    live "/companies/open", CompanyLive.OpenCompany, :index
    live "/companies/open/:id", CompanyLive.OpenCompany, :open

    live "/companies/:id", CompanyLive.Show, :show
    live "/companies/:id/show/edit", CompanyLive.Show, :edit

    live "/accounting_periods", AccountingPeriodLive.Index, :index
    live "/accounting_periods/new", AccountingPeriodLive.Index, :new
    live "/accounting_periods/:id/edit", AccountingPeriodLive.Index, :edit

    live "/accounting_periods/:id", AccountingPeriodLive.Show, :show
    live "/accounting_periods/:id/show/edit", AccountingPeriodLive.Show, :edit

    live "/departments", DepartmentLive.Index, :index
    live "/departments/new", DepartmentLive.Index, :new
    live "/departments/:id/edit", DepartmentLive.Index, :edit

    live "/departments/:id", DepartmentLive.Show, :show
    live "/departments/:id/show/edit", DepartmentLive.Show, :edit

    live "/cost_centres", CostCentreLive.Index, :index
    live "/cost_centres/new", CostCentreLive.Index, :new
    live "/cost_centres/:id/edit", CostCentreLive.Index, :edit

    live "/cost_centres/:id", CostCentreLive.Show, :show
    live "/cost_centres/:id/show/edit", CostCentreLive.Show, :edit
  end

  scope "/", SageWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm

    live "/organisations", OrganisationLive.Index, :index
    live "/organisations/:id/edit", OrganisationLive.Index, :edit

    live "/organisations/:id", OrganisationLive.Show, :show
    live "/organisations/:id/show/edit", OrganisationLive.Show, :edit
  end
end
