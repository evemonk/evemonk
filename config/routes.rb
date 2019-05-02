# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :backoffice do
    # TODO: spec this
    mount Sidekiq::Web, at: 'sidekiq'
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

    resource :change_password, only: :create

    resource :request_password_reset, only: :create

    resource :reset_password, only: :create

    resources :sessions, only: [:index, :destroy]

    resource :profile, only: :show

    resources :characters, only: [:index, :show, :destroy]

    namespace :eve do
      resources :alliances, only: [:index, :show] do
        resources :characters, only: :index, controller: :alliance_characters

        resources :corporations, only: :index, controller: :alliance_corporations
      end

      resources :corporations, only: :index
    end
  end

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'

  get '*path', to: 'welcome#index'
end
