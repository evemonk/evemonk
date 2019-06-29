# frozen_string_literal: true

module Api
  module Eve
    class CorporationsController < BaseController
      skip_before_action :authenticate

      def index
        @corporations = ::Eve::CorporationsSearcher.new(params[:q],
                                                        policy_scope(::Eve::Corporation))
                                                   .search
                                                   .page(params[:page])
      end

      def show
        @corporation = ::Eve::Corporation.find_by!(corporation_id: params[:id])

        authorize(@corporation)
      end
    end
  end
end
