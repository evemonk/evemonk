# frozen_string_literal: true

module Api
  module Eve
    class AlliancesController < BaseController
      skip_before_action :authenticate

      def index
        @alliances = policy_scope(::Eve::Alliance).includes(:faction,
                                                            :creator_corporation,
                                                            :creator,
                                                            :executor_corporation)
                                                  .page(params[:page])
      end

      def show
        @alliance = ::Eve::Alliance.find_by!(alliance_id: params[:id])

        authorize(@alliance)
      end
    end
  end
end
