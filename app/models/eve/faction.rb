# frozen_string_literal: true

module Eve
  class Faction < ApplicationRecord
    include Imageable
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :corporation, optional: true

    belongs_to :militia_corporation,
      class_name: "Eve::Corporation",
      optional: true

    belongs_to :solar_system, class_name: "Eve::System", optional: true

    has_many :alliances # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :standings, as: :standingable # rubocop:disable Rails/HasManyOrHasOneDependent

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
