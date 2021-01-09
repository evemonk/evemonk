# frozen_string_literal: true

module Api
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception, unless: -> { request.format.json? }

    before_action :verify_requested_format!

    respond_to :json

    # :nocov:
    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    rescue_from ActionController::UnknownFormat do
      head :not_acceptable
    end
    # :nocov:
  end
end
