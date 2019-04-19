# frozen_string_literal: true

module Api
  module Eve
    class AlliancesController < BaseController
      skip_before_action :authenticate

      def index
        @alliances = ::Eve::AlliancesSearcher.new(params[:q], policy_scope(::Eve::Alliance))
                                             .query
                                             .page(params[:page])
      end

      def show
        @alliance = ::Eve::Alliance.find_by!(alliance_id: params[:id])

        authorize(@alliance)
      end
    end
  end
end
