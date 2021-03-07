# frozen_string_literal: true

module Eve
  class CharacterCorporationHistoryRecord < ApplicationRecord
    # # TODO: has_paper_trail
    #
    # belongs_to :character,
    #   class_name: "Eve::Character",
    #   primary_key: "character_id"
    #
    # belongs_to :corporation,
    #   class_name: "Eve::Corporation",
    #   primary_key: "corporation_id",
    #   optional: true
  end
end
