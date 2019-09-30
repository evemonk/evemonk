# frozen_string_literal: true

class CharacterAssetsController < ApplicationController
  def index
    @character = Character.eager_load(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:id])
      .decorate

    authorize(@character)

    @assets = @character.character_assets.includes(:type)
  end
end
