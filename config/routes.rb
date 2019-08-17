# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  namespace :backoffice do
    # TODO: spec this
    # https://github.com/mperham/sidekiq/wiki/Monitoring#rails-http-basic-auth-from-routes
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      # Protect against timing attacks:
      # - See https://codahale.com/a-lesson-in-timing-attacks/
      # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
      # - Use & (do not use &&) so that it doesn't short circuit.
      # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end
    mount Sidekiq::Web, at: "sidekiq"
  end

  namespace :auth do
    namespace :eve_online_sso do
      resource :callback, only: :show
    end
  end

  namespace :api, defaults: {format: "json"} do
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

      resources :corporations, only: [:index, :show] do
        resources :characters, only: :index, controller: :corporation_characters
      end

      resources :characters, only: [:index, :show] do
        resources :corporations_history, only: :index, controller: :character_corporations_history
      end

      resources :types, only: [:index, :show]

      resource :server_status_last, only: :show
    end
  end

  # You can have the root of your site routed with "root"
  root to: "welcome#index"

  get "*path", to: "welcome#index"
end
