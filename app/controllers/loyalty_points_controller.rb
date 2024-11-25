# frozen_string_literal: true

class LoyaltyPointsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @loyalty_points = @character.loyalty_points
      .includes(:corporation)
  end
end
