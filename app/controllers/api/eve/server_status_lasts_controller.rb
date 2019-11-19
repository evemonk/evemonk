# frozen_string_literal: true

module Api
  module Eve
    class ServerStatusLastsController < BaseController
      skip_before_action :authenticate

      def show
        @server_status = policy_scope(::Eve::ServerStatus).last.decorate
      end
    end
  end
end
