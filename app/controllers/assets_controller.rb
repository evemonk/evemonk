# frozen_string_literal: true

class AssetsController < ApplicationController
  def index
    @character = policy_scope(Character).eager_load(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @assets = @character.character_assets.includes(:type)
  end
end
