Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :signups, only: :create

    resource :sign_outs, only: :destroy

    resources :sessions, only: [:index, :create, :destroy]

    resources :api_keys, only: [:index, :create, :show, :update, :destroy]

    resource :profile, only: :show
  end

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
