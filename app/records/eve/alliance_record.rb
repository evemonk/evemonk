# frozen_string_literal: true

module Eve
  class AllianceRecord < ApplicationRecord
    self.table_name = "eve_alliances"

    # has_paper_trail
    #
    # searchkick
    #
    # belongs_to :creator_corporation,
    #   class_name: "Eve::Corporation",
    #   primary_key: "corporation_id",
    #   optional: true
    #
    # belongs_to :creator,
    #   class_name: "Eve::Character",
    #   primary_key: "character_id",
    #   optional: true
    #
    # belongs_to :executor_corporation,
    #   class_name: "Eve::Corporation",
    #   primary_key: "corporation_id",
    #   foreign_key: "executor_corporation_id",
    #   optional: true
    #
    # belongs_to :faction,
    #   primary_key: "faction_id",
    #   optional: true

    has_many :corporation_records,
      primary_key: "alliance_id",
      foreign_key: "alliance_id"

    # has_many :characters,
    #   through: :corporations
    #
    # has_many :corporation_alliance_histories,
    #   primary_key: "alliance_id"
    #
    # after_create_commit :reset_corporations_count
    #
    # after_create_commit :reset_characters_count
    #
    # def search_data
    #   {
    #     name: name,
    #     ticker: ticker
    #   }
    # end
    #
    # def reset_corporations_count
    #   update_columns(corporations_count: corporations.count)
    # end
    #
    # def reset_characters_count
    #   update_columns(characters_count: corporations.sum(:member_count))
    # end
  end
end
