# frozen_string_literal: true

module Api
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception, unless: -> { request.format.json? }

    before_action :verify_requested_format!

    respond_to :json

    before_action :authenticate

    attr_reader :current_user

    # :nocov:
    # rescue_from ActionController::ParameterMissing do |exception|
    #   @exception = exception

    #   render :exception, status: :unprocessable_entity
    # end

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    rescue_from ActionController::UnknownFormat do
      head :not_acceptable
    end

    rescue_from Pundit::NotAuthorizedError do
      head :forbidden
    end
    # :nocov:

    def index
    end

    private

    def authenticate_by_token
      authenticate_with_http_token do |token,|
        @current_user = User.joins(:sessions)
          .find_by(sessions: {token: token})
      end
    end

    def authenticate
      authenticate_by_token || render_unauthorized
    end

    def render_unauthorized
      render json: {error: "Access denied"}, status: :unauthorized
    end
  end
end
