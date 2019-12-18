# frozen_string_literal: true

class SkillsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(character_skills: :skill)
      .find_by!(character_id: params[:character_id])
      .decorate
  end
end
