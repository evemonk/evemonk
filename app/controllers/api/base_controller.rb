# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include Pundit

    before_action :authenticate!

    attr_reader :current_user

    # :nocov:
    # rescue_from ActionController::ParameterMissing do |exception|
    #   @exception = exception
    #
    #   render :exception, status: :unprocessable_entity
    # end

    # rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    #   render :errors, status: :unprocessable_entity
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

    private

    def authenticate!
      authenticate_or_request_with_http_token do |token,|
        @current_user = User.joins(:sessions)
                            .find_by(sessions: { token: token })
      end
    end

    def authenticate
      authenticate_with_http_token do |token,|
        @current_user = User.joins(:sessions)
                            .find_by(sessions: { token: token })
      end
    end
  end
end
