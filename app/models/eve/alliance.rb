# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    searchkick

    belongs_to :creator_corporation,
               primary_key: :corporation_id,
               class_name: "Eve::Corporation",
               optional: true

    belongs_to :creator,
               primary_key: :character_id,
               class_name: "Eve::Character",
               optional: true

    belongs_to :executor_corporation,
               foreign_key: :executor_corporation_id,
               primary_key: :corporation_id,
               class_name: "Eve::Corporation",
               optional: true

    belongs_to :faction,
               primary_key: :faction_id,
               optional: true

    has_many :alliance_corporations, primary_key: :alliance_id

    has_many :corporations, through: :alliance_corporations

    has_many :characters, through: :corporations

    def characters_count
      corporations.sum("eve_corporations.member_count")
    end

    def search_data
      {
        name: name,
        ticker: ticker,
      }
    end
  end
end
