# frozen_string_literal: true

module Eve
  class CharacterCorporationHistory < ApplicationRecord
    belongs_to :character

    belongs_to :corporation, optional: true
  end
end
