# frozen_string_literal: true

class SkillsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @character_skills_tree = CharacterSkillsTree.new(@character).preload
  end
end
