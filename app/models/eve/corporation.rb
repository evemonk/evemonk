# frozen_string_literal: true

module Eve
  class Corporation < ApplicationRecord
    has_paper_trail

    searchkick

    belongs_to :alliance,
               primary_key: :alliance_id,
               optional: true

    belongs_to :ceo,
               primary_key: :character_id,
               class_name: "Eve::Character",
               optional: true

    belongs_to :creator,
               primary_key: :character_id,
               class_name: "Eve::Character",
               optional: true

    belongs_to :faction,
               primary_key: :faction_id,
               optional: true

    # belongs_to :home_station_id

    has_many :characters, primary_key: :corporation_id

    has_many :corporation_alliance_histories,
             primary_key: :corporation_id

    # after_create_commit
    #
    # after_destroy_commit

    def search_data
      {
        name: name,
        ticker: ticker,
      }
    end
  end
end
