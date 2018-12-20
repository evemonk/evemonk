# frozen_string_literal: true

module Eve
  class Character < ApplicationRecord
    belongs_to :alliance, primary_key: :alliance_id, optional: true

    belongs_to :ancestry, primary_key: :ancestry_id, optional: true

    belongs_to :bloodline, primary_key: :bloodline_id, optional: true

    belongs_to :corporation, primary_key: :corporation_id, optional: true

    belongs_to :faction, primary_key: :faction_id, optional: true

    belongs_to :race, primary_key: :race_id, optional: true
  end
end
