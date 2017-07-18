module Api
  class BaseController < ApplicationController
    before_action :authenticate!

    attr_reader :current_user

    helper_method :parent, :collection, :resource, :current_user

    def create
      build_resource

      resource.save!
    end

    def update
      resource.update!(resource_params)
    end

    def destroy
      resource.destroy!

      head :ok
    end

    # :nocov:
    rescue_from ActionController::ParameterMissing do |exception|
      @exception = exception

      render :exception, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
      render :errors, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    # rescue_from Pundit::NotAuthorizedError do
    #   head :forbidden
    # end

    rescue_from ActionController::UnknownFormat do
      head :not_acceptable
    end
    # :nocov:

    private

    def authenticate!
      authenticate_or_request_with_http_token do |token,|
        @current_user = User.joins(:sessions)
                            .where(sessions: { token: token })
                            .first
      end
    end

    def authenticate
      authenticate_with_http_token do |token,|
        @current_user = User.joins(:sessions)
                            .where(sessions: { token: token })
                            .first
      end
    end

    def parent
      raise NotImplementedError
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
