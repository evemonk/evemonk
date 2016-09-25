Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :api, defaults: { format: 'json' } do
    resources :signups, only: :create

    resources :sessions, only: :create

    resources :api_keys, only: [:index, :create, :show, :update, :destroy]
  end

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
