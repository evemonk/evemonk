# frozen_string_literal: true

module Eve
  class Faction < ApplicationRecord
    has_many :alliances, primary_key: :faction_id

    belongs_to :corporation, primary_key: :corporation_id, optional: true

    # belongs_to :militia_corporation_id

    belongs_to :solar_system,
               foreign_key: :solar_system_id,
               primary_key: :system_id,
               class_name: "Eve::System",
               optional: true
  end
end
