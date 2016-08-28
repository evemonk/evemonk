module Api
  class BaseController < ApplicationController
    include Pundit

    skip_before_action :verify_authenticity_token

    before_action :authenticate

    after_action :verify_authorized, except: :index

    after_action :verify_policy_scoped, only: :index

    attr_reader :current_user

    helper_method :parent, :collection, :resource, :current_user

    def show
      authorize(resource)
    end

    def create
      build_resource

      authorize(resource)

      resource.save!
    end

    def update
      authorize(resource)

      resource.update!(resource_params)
    end

    def destroy
      authorize(resource)

      resource.destroy!

      head :ok
    end

    # :nocov:
    rescue_from ActionController::ParameterMissing do |exception|
      @exception = exception

      render :exception, status: :unprocessable_entity
    end
    # :nocov:

    # :nocov:
    rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
      render :errors, status: :unprocessable_entity
    end
    # :nocov:

    # :nocov:
    rescue_from ActiveRecord::RecordNotFound do |exception|
      @exception = exception

      render :exception, status: :not_found
    end
    # :nocov:

    # :nocov:
    rescue_from Pundit::NotAuthorizedError do
      head :forbidden
    end
    # :nocov:

    private

    def authenticate
      authenticate_or_request_with_http_token do |token, options| # rubocop:disable Lint/UnusedBlockArgument
        @current_user = User.find_by(token: token)
      end
    end

    def resource
      raise NotImplementedError
    end

    def resource_params
      raise NotImplementedError
    end

    def build_resource
      raise NotImplementedError
    end

    def collection
      raise NotImplementedError
    end
  end
end
