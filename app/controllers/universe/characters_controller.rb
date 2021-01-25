# frozen_string_literal: true

module Universe
  class CharactersController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @characters = ::Eve::CharactersSearcher
        .new(params[:q])
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @character = ::Eve::Character
        .includes(:alliance, :corporation)
        .find_by!(character_id: params[:id])
        .decorate

      @character_corporation_histories = Eve::CharacterCorporationHistory.where(character_id: @character.character_id)
        .includes(:corporation)
        .order(start_date: :desc)
        .decorate
    end
  end
end
