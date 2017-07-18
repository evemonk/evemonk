Rails.application.routes.draw do
  namespace :backoffice do
    # TODO: spec this
    mount PgHero::Engine, at: 'pghero'
  end

  namespace :api, defaults: { format: 'json' } do
    resource :sign_up, only: :create

    resource :sign_in, only: :create

    resource :sign_out, only: :destroy

    resources :sessions, only: [:index, :destroy]

    resource :profile, only: :show
  end

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
