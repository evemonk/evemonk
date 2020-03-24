# frozen_string_literal: true

class AssetsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @assets = @character.character_assets
      .includes(:type)
  end
end
