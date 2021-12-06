# frozen_string_literal: true

module Universe
  class AlliancesController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      collection = Eve::SearchAlliancesQuery
        .new(params[:q])
        .query

      @pagy, @alliances = pagy(collection)
    end

    def show
      @alliance = ::Eve::Alliance
        .includes(:faction, :creator_corporation, :creator, :executor_corporation)
        .find_by!(alliance_id: params[:id])

      @corporations = ::Eve::Corporation
        .where(alliance: @alliance)
        .order(:name)
        .includes(:faction)
    end
  end
end
