# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    has_paper_trail

    searchkick

    belongs_to :creator_corporation,
      class_name: "Eve::Corporation",
      primary_key: "corporation_id",
      optional: true

    belongs_to :creator,
      class_name: "Eve::Character",
      primary_key: "character_id",
      optional: true

    belongs_to :executor_corporation,
      class_name: "Eve::Corporation",
      primary_key: "corporation_id",
      foreign_key: "executor_corporation_id",
      optional: true

    belongs_to :faction,
      primary_key: "faction_id",
      optional: true

    has_many :alliance_corporations, primary_key: "alliance_id"

    has_many :corporations, through: :alliance_corporations

    has_many :characters, through: :corporations

    after_create_commit :reset_characters_count

    def search_data
      {
        name: name,
        ticker: ticker,
      }
    end

    def reset_characters_count
      update_columns(characters_count: corporations.sum(:member_count))
    end
  end
end
