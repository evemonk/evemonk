# frozen_string_literal: true

class RenameSkillsToCharacterSkills < ActiveRecord::Migration[6.0]
  def change
    rename_table :skills, :character_skills
  end
end
