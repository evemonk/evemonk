# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    include PgSearch::Model
    include ActionView::Helpers::NumberHelper
    include ImageProxy

    has_paper_trail

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

    has_many :corporations,
      primary_key: "alliance_id"

    has_many :characters,
      through: :corporations

    has_many :corporation_alliance_histories,
      primary_key: "alliance_id"

    after_create_commit :reset_corporations_count

    after_create_commit :reset_characters_count

    pg_search_scope :search_by_name_and_ticker, against: [:name, :ticker]

    has_one_attached :logo

    def reset_corporations_count
      update_columns(corporations_count: corporations.count)
    end

    def reset_characters_count
      update_columns(characters_count: corporations.sum(:member_count))
    end

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=128"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=256"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/alliances/#{alliance_id}/logo?size=512"
    end

    def formatted_corporations_count
      number_with_delimiter(corporations_count, delimiter: " ")
    end

    def formatted_characters_count
      number_with_delimiter(characters_count, delimiter: " ")
    end

    def to_key
      key = alliance_id
      [key] if key
    end
  end
end
