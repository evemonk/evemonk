# frozen_string_literal: true

module Api
  module Eve
    class CorporationsController < BaseController
      skip_before_action :authenticate

      def index
        @corporations = ::Eve::CorporationsSearcher
          .new(params[:q], policy_scope(::Eve::Corporation))
          .search
          .page(params[:page])
          .decorate
      end

      def show
        @corporation = policy_scope(::Eve::Corporation)
          .find_by!(corporation_id: params[:id])
          .decorate

        skip_authorization
      end
    end
  end
end
