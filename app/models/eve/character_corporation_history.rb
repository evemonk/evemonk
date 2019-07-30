# frozen_string_literal: true

module Eve
  class CharacterCorporationHistory < ApplicationRecord
    belongs_to :character,
               primary_key: :character_id,
               class_name: "Eve::Character"

    belongs_to :corporation,
               primary_key: :corporation_id,
               class_name: "Eve::Corporation",
               optional: true
  end
end
