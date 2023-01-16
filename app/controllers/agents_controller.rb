# frozen_string_literal: true

class AgentsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @form = CharacterAgentDivisionsFilterForm.new(params[:filter])

    @character_agents = CharacterAgents.new(@character, params[:filter]).query
  end
end
