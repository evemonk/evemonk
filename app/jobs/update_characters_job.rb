# frozen_string_literal: true

class UpdateCharactersJob < ApplicationJob
  queue_as :important

  def perform
    return unless Flipper.enabled?(:update_characters_job)

    Character.with_valid_tokens.pluck(:character_id).sort.uniq.each do |character_id|
      UpdateCharacterInfoService.new(character_id).execute
    end

    # TODO: broken?
    # Eve::UpdateMarketPricesJob.perform_later

    ImportMissingJob.perform_later
  end
end
