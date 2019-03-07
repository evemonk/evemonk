# frozen_string_literal: true

module Api
  module Eve
    class CorporationsController < BaseController
      skip_before_action :authenticate

      def index
        @corporations = policy_scope(::Eve::Corporation).page(params[:page])
      end
    end
  end
end
