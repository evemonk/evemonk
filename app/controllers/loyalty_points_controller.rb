# frozen_string_literal: true

class LoyaltyPointsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @loyalty_points = @character.loyalty_points
      .includes(:corporation)
  end
end
