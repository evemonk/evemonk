# frozen_string_literal: true

module Universe
  class AlliancesController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @alliances = ::Eve::AlliancesSearcher
        .new(params[:q])
        .search
        .page(params[:page])
    end

    def show
      action = UniverseAlliancesShowAction.new.perform(params[:id])

      @alliance = action.alliance
      @corporations = action.corporations

      # @alliance = ::Eve::Alliance
      #   .includes(:faction, :creator_corporation, :creator, :executor_corporation)
      #   .find_by!(alliance_id: params[:id])
      #
      # @corporations = ::Eve::Corporation
      #   .where(alliance: @alliance)
      #   .order(:name)
      #   .includes(:faction)
    end
  end
end
