# frozen_string_literal: true

class UpdateCharactersJob < ApplicationJob
  queue_as :realtime

  def perform
    CharacterScope.includes(:character)
                  .where(esi_token_valid: true)
                  .find_each do |character_scope|
      UpdateCharacterInfoService.new(character_scope.character.character_id).call
    end
  end
end
