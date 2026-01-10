# frozen_string_literal: true

class SkillsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @character_skills_tree = CharacterSkillsTree.new(@character).preload
  end
end
