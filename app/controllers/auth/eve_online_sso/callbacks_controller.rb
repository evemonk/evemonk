# frozen_string_literal: true

module Auth
  module EveOnlineSso
    class CallbacksController < ApplicationController
      rescue_from EveOnline::Exceptions::ServiceUnavailable, with: :handle_service_unavailable

      rescue_from EveOnline::Exceptions::InternalServerError, with: :handle_internal_server_error

      rescue_from EveOnline::Exceptions::BadGateway, with: :handle_bad_gateway

      rescue_from EveOnline::Exceptions::Timeout, with: :handle_timeout

      def show
        service = EveOnlineCallbackService.new(current_user, request)

        service.save!

        skip_authorization

        redirect_to characters_path
      end

      private

      def handle_service_unavailable
        render inline: "Service Unavailable (503). Try again later."
      end

      def handle_internal_server_error
        render inline: "Internal Server Error (500). Try again later."
      end

      def handle_bad_gateway
        render inline: "Bad Gateway (502). Try again later."
      end

      def handle_timeout
        render inline: "Timeout Error. Try again later."
      end
    end
  end
end
