# frozen_string_literal: true

class AgentsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation, agents_standings: {standingable: :division})
      .find_by!(character_id: params[:character_id])
  end
end
