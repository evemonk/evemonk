# frozen_string_literal: true

module Eve
  class Character < ApplicationRecord
    include PgSearch::Model
    include ImageProxy

    has_paper_trail

    belongs_to :alliance, optional: true

    belongs_to :ancestry,
      primary_key: "ancestry_id",
      optional: true

    belongs_to :bloodline,
      primary_key: "bloodline_id",
      optional: true

    belongs_to :corporation,
      primary_key: "corporation_id",
      optional: true

    belongs_to :faction,
      primary_key: "faction_id",
      optional: true

    belongs_to :race,
      primary_key: "race_id",
      optional: true

    has_many :character_corporation_histories,
      primary_key: "character_id",
      dependent: :destroy

    pg_search_scope :search_by_name, against: :name

    has_one_attached :portrait

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=128"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=256"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=512"
    end

    def icon_gigantic
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=1024"
    end

    def sanitized_description
      Rails::Html::FullSanitizer.new.sanitize(description)
    end

    def rounded_security_status
      security_status&.round(1)
    end

    def to_key
      key = character_id
      [key] if key
    end

    def to_param
      character_id&.to_s
    end
  end
end
