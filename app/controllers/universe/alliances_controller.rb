# frozen_string_literal: true

module Universe
  class AlliancesController < ApplicationController
    skip_before_action :require_login

    def index
      @alliances = ::Eve::AlliancesSearcher
        .new(params[:q])
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @alliance = ::Eve::Alliance
        .includes(:faction, :creator_corporation, :creator, :executor_corporation)
        .find_by!(alliance_id: params[:id])
        .decorate

      @corporations = ::Eve::Corporation
        .where(alliance: @alliance)
        .order(:name)
        .includes(:faction)
        .decorate
    end
  end
end
