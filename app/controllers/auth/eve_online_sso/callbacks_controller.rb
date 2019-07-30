# frozen_string_literal: true

module Auth
  module EveOnlineSso
    class CallbacksController < ApplicationController
      rescue_from EveOnline::Exceptions::ServiceUnavailable, with: :handle_service_unavailable

      def show
        form = Api::EveOnlineForm.new(request)

        form.save!

        redirect_to "/autosignin/#{form.session.token}"
      end

      private

      def handle_service_unavailable
        render inline: "Net::HTTPServiceUnavailable (503). Try again later."
      end
    end
  end
end
