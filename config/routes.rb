Rails.application.routes.draw do
  namespace :api do
    resources :docs, only: :index

    resources :signups, only: :create
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
