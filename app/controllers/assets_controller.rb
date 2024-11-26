# frozen_string_literal: true

class AssetsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @assets = @character.character_assets
      .includes(:type)
  end
end
