# frozen_string_literal: true

module Api
  module Eve
    class AllianceCorporationsController < BaseController
      skip_before_action :authenticate

      def index
        alliance = policy_scope(::Eve::Alliance).find_by!(alliance_id: params[:alliance_id])
          .decorate

        @corporations = policy_scope(::Eve::Corporation).where(alliance: alliance)
          .includes(:alliance,
                                                                  :ceo,
                                                                  :creator,
                                                                  :faction)
          .page(params[:page])
          .decorate
      end
    end
  end
end
