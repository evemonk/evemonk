Rails.application.routes.draw do
  namespace :backoffice do
    # TODO: spec this
    mount PgHero::Engine, at: 'pghero'
  end

  namespace :auth do
    namespace :eve_online_sso do
      resource :callback, only: :show
    end
  end

  namespace :api, defaults: { format: 'json' } do
    resources :docs, only: :index

    resource :sign_up, only: :create

    resource :sign_in, only: :create

    resource :sign_out, only: :destroy

    resources :sessions, only: [:index, :destroy]

    resource :profile, only: :show

    resources :characters, only: [:index, :show, :destroy]
  end

  # You can have the root of your site routed with "root"
  root 'main#index'

  get '*path', to: 'main#index'
end
