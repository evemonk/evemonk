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

        redirect_to characters_path, notice: t(".successful_html", name: service.name)
      end

      private

      def handle_service_unavailable
        redirect_to characters_path, alert: t(".service_unavailable")
      end

      def handle_internal_server_error
        redirect_to characters_path, alert: t(".internal_server_error")
      end

      def handle_bad_gateway
        redirect_to characters_path, alert: t(".bad_gateway")
      end

      def handle_timeout
        redirect_to characters_path, alert: t(".timeout")
      end
    end
  end
end
