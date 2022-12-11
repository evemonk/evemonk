# frozen_string_literal: true

module Eve
  class CharacterCorporationHistory < ApplicationRecord
    # TODO: has_paper_trail

    belongs_to :character

    belongs_to :corporation,
      class_name: "Eve::Corporation",
      primary_key: "corporation_id",
      optional: true
  end
end
