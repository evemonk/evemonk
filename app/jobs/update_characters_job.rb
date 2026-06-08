# frozen_string_literal: true

class UpdateCharactersJob < ApplicationJob
  queue_as :realtime

  def perform
    CharacterScope.with_valid_tokens
      .includes(:character)
      .find_each do |scope|
        UpdateCharacterInfoService.new(scope.character.character_id).call
    end
  end
end
