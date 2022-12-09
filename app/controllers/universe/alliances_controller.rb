# frozen_string_literal: true

module Universe
  class AlliancesController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @alliances = Eve::SearchAlliancesQuery
        .new(params[:q])
        .query
        .page(params[:page])
    end

    def show
      @alliance = ::Eve::Alliance
        .includes(:faction, :creator_corporation, :creator, :executor_corporation)
        .find(params[:id])
    end
  end
end
