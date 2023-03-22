# frozen_string_literal: true

class CharacterCorporationHistory < ApplicationRecord
  belongs_to :character, primary_key: "character_id"

  belongs_to :corporation, class_name: "Eve::Corporation", optional: true
end
