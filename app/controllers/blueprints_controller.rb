# frozen_string_literal: true

class BlueprintsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @character_blueprints = @character.character_blueprints
      .includes(:blueprint)
  end

  def show
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @character_blueprints = @character.character_blueprints
      .includes(:blueprint)

    @blueprint = @character.character_blueprints
      .includes(:blueprint)
      .where(item_id: params[:id])
      .first
  end
end
