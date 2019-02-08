# frozen_string_literal: true

module Api
  module Eve
    class AllianceCorporationsController < BaseController
      skip_before_action :authenticate

      def index
        # @alliance = policy_scope(::Eve::Alliance).find_by!(alliance_id: params[:alliance_id])
        #
        # @corporations = ::Eve::Corporation.where(alliance: @alliance)
        #                                   .page(params[:page])
      end
    end
  end
end
