# frozen_string_literal: true

class LoyaltyPointsController < ApplicationController
  def index
    @character = policy_scope(Character).eager_load(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @loyalty_points = @character.loyalty_points
      .includes(:corporation)
  end
end
