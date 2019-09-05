# frozen_string_literal: true

module Universe
  class AlliancesController < ApplicationController
    include Pundit

    after_action :verify_authorized, except: :index

    after_action :verify_policy_scoped, only: :index

    attr_reader :current_user

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

      @corporations = policy_scope(::Eve::Corporation)
        .where(alliance: @alliance)
        .includes(:alliance, :ceo, :creator, :faction)
        .page(params[:page])
        .decorate

      skip_authorization
    end
  end
end
