# frozen_string_literal: true

module Universe
  class CharactersController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      # @characters = Eve::SearchCharactersQuery.new(params[:q]).query.page(params[:page])

      @characters = policy_scope(Eve::Character).order(:name).page(params[:page])
    end

    def show
      # @character = ::Eve::Character.includes(:alliance, :corporation).find(params[:id])

      @character = Eve::Character.includes(:alliance, :corporation).find(params[:id])

      authorize @character

      @character_corporation_histories = Eve::CharacterCorporationHistory.where(character: @character)
        .includes(:corporation)
        .order(start_date: :desc)
    end
  end
end
