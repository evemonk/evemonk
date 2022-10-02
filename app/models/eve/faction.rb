# frozen_string_literal: true

module Eve
  class Faction < ApplicationRecord
    include Imageable
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :corporation,
      primary_key: "corporation_id",
      optional: true

    belongs_to :militia_corporation,
      class_name: "Eve::Corporation",
      primary_key: "corporation_id",
      foreign_key: "militia_corporation_id",
      optional: true

    belongs_to :solar_system,
      class_name: "Eve::System",
      primary_key: "system_id",
      foreign_key: "solar_system_id",
      optional: true

    has_many :alliances, primary_key: "faction_id"

    has_many :standings, as: :standingable

    def icon_tiny
      corporations_logo_url(32)
    end

    def icon_small
      corporations_logo_url(64)
    end

    def icon_medium
      corporations_logo_url(128)
    end

    private

    def corporations_logo_url(size)
      imageable_url("corporations", faction_id, "logo", size)
    end
  end
end
