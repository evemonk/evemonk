# frozen_string_literal: true

module Universe
  class CorporationsController < ApplicationController
    include Pundit

    after_action :verify_authorized, except: :index

    after_action :verify_policy_scoped, only: :index

    attr_reader :current_user

    def index
      @corporations = ::Eve::CorporationsSearcher
        .new(params[:q], policy_scope(::Eve::Corporation))
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @corporation = policy_scope(::Eve::Corporation)
        .find_by!(corporation_id: params[:id])
        .decorate

      @characters = Eve::Character.where(corporation_id: @corporation.corporation_id)
                                  .decorate

      # @history = Eve::CharacterCorporationHistory.where(corporation: @corporation)
      #                                            .includes(:character)
      #                                            .decorate

      # @characters = policy_scope(::Eve::Character)
      #   .where(corporation: @corporation)
      #   .includes(:alliance, :ancestry, :bloodline, :corporation, :faction,
      #             :race, :character_corporation_histories)
      #   .page(params[:page])
      #   .decorate

      skip_authorization
    end
  end
end
