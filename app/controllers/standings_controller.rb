# frozen_string_literal: true

class StandingsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation, :factions_standings,
        :corporations_standings, :agents_standings)
      .find_by!(character_id: params[:character_id])
  end
end
