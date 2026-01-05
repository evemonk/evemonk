# frozen_string_literal: true

class HelpsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
  end
end
