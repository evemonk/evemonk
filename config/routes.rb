# frozen_string_literal: true

if Rails.env.development?
  require "sidekiq/web"
end

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  post "/graphql", to: "graphql#execute"

  devise_for :users

  get ".well-known/change-password", to: "well_known#change_password"

  if Rails.env.development?
    namespace :backoffice do
      mount Sidekiq::Web, at: "sidekiq"
    end
  end

  namespace :universe do
    resources :alliances, only: [:index, :show] do
      resource :hovercard, only: :show, controller: "alliances/hovercards"
    end

    resources :corporations, only: [:index, :show]

    resources :characters, only: [:index, :show]

    resources :categories, only: [:index, :show]

    resources :groups, only: :show

    resources :market_groups, only: [:index, :show]

    resources :types, only: :show

    resources :search, only: :index
  end

  resources :characters, only: [:index, :show, :update, :destroy] do
    resources :assets, only: :index

    resources :loyalty_points, only: :index

    resources :employment_histories, only: :index

    resources :skills, only: :index

    resources :skillqueues, only: :index

    resources :mails, only: :index

    resources :standings, only: :index

    resources :agents, only: :index

    resources :wallet_journals, only: :index

    resources :industry_jobs, only: :index

    resources :blueprints, only: [:index, :show]

    # resources :manufacturing_jobs, only: [:index, :new, :create, :update, :show]

    resources :orders, only: :index

    resources :training_queues, only: :index

    resources :certificates, only: :index

    resources :settings, only: :index
  end

  resource :profile, only: :show

  resource :faq, only: :show

  namespace :blueprints do
    resources :calculator, only: [:index, :show]
  end

  namespace :auth do
    namespace :eve_online_sso do
      resource :callback, only: :show
    end
  end

  namespace :api, defaults: {format: "json"} do
    namespace :eve do
      resources :types, only: [:index, :show]

      resources :blueprints, only: :index

      resources :manufacturing_items, only: :index
    end
  end

  namespace :admin do
    namespace :eve do
      resources :alliances, only: [:index, :show]

      resources :corporations, only: [:index, :show]

      resources :characters, only: [:index, :show]

      resources :races, only: [:index, :show]

      resources :bloodlines, only: [:index, :show]

      resources :ancestries, only: [:index, :show]

      resources :factions, only: [:index, :show]

      resources :groups, only: [:index, :show]

      resources :market_groups, only: [:index, :show]

      resources :categories, only: [:index, :show]

      resources :constellations, only: [:index, :show]

      resources :stations, only: [:index, :show]

      resources :systems, only: [:index, :show]

      resources :units, only: [:index, :show]
    end

    resources :users

    resources :characters, only: [:index, :show]

    resources :settings

    # resources :sessions
    # resources :skillqueues
    # resources :character_skills
    # resources :character_mail_labels
    # resources :character_orders
    # resources :character_corporation_histories
    # resources :loyalty_points
    # resources :etags
    # resources :standings
    # resources :industry_jobs
    # resources :characters
    # resources :wallet_transactions
    # resources :wallet_journals
    # resources :character_implants
    # resources :character_assets
    # resources :character_killmails
    # resources :manufacturing_jobs
    # resources :character_blueprints

    root to: "settings#index"
  end

  root to: "welcome#index"
end
