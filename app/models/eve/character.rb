# frozen_string_literal: true

module Eve
  class Character < ApplicationRecord
    include PgSearch::Model
    include Imageable

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
      character_portrait_url(32)
    end

    def icon_small
      character_portrait_url(64)
    end

    def icon_medium
      character_portrait_url(128)
    end

    def icon_large
      character_portrait_url(256)
    end

    def icon_huge
      character_portrait_url(512)
    end

    def icon_gigantic
      character_portrait_url(1024)
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

    private

    def character_portrait_url(size)
      imageable_url("characters", character_id, "portrait", size)
    end
  end
end
