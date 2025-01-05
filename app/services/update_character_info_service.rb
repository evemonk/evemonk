# frozen_string_literal: true

class UpdateCharacterInfoService
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def execute
    # CharacterJob.perform_later(character_id)
    #
    # CharacterWalletJob.perform_later(character_id)
    #
    # CharacterAttributesJob.perform_later(character_id)
    #
    # CharacterLocationJob.perform_later(character_id)
    #
    # CharacterShipJob.perform_later(character_id)
    #
    # CharacterImplantsJob.perform_later(character_id)
    #
    # CharacterLoyaltyPointsJob.perform_later(character_id)
    #
    # CharacterSkillsJob.perform_later(character_id)
    #
    # CharacterSkillqueueJob.perform_later(character_id)
    #
    # CharacterAssetsJob.perform_later(character_id)
    #
    # CharacterCorporationHistoryJob.perform_later(character_id)
    #
    # CharacterMailLabelsJob.perform_later(character_id)
    #
    # CharacterStandingsJob.perform_later(character_id)
    #
    # CharacterWalletJournalJob.perform_later(character_id)
    #
    # CharacterWalletTransactionsJob.perform_later(character_id)
    #
    # CharacterBlueprintsJob.perform_later(character_id)
    #
    # CharacterIndustryJobsJob.perform_later(character_id)
    #
    # CharacterOrdersJob.perform_later(character_id)
  end
end
