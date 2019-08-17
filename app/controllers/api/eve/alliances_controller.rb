# frozen_string_literal: true

module Api
  module Eve
    class AlliancesController < BaseController
      skip_before_action :authenticate

      def index
        @alliances = ::Eve::AlliancesSearcher
          .new(params[:q], policy_scope(::Eve::Alliance))
          .search
          .page(params[:page])
          .decorate
      end

      def show
        @alliance = policy_scope(::Eve::Alliance)
          .includes(:faction, :creator_corporation, :creator,
                    :executor_corporation)
          .find_by!(alliance_id: params[:id])
          .decorate

        skip_authorization
      end
    end
  end
end
