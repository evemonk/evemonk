# frozen_string_literal: true

class UpdateCharactersJob < ActiveJob::Base
  queue_as :default

  def perform
    Character.pluck(:character_id).sort.uniq.each do |character_id|
      UpdateCharacterInfoService.new(character_id).execute
    end
  end
end
