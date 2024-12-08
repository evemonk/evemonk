# frozen_string_literal: true

class BlueprintsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
  end

  # def show
  #   @character = Character
  #     .includes(:alliance, :corporation)
  #     .find_by!(character_id: params[:character_id])
  #
  #   authorize @character
  #
  #   @blueprint = @character.character_blueprints
  #     .includes(:blueprint)
  #     .find_by!(item_id: params[:id])
  # end
end
