# frozen_string_literal: true

module Eve
  class Character < ApplicationRecord
    include PgSearch::Model
    include Imageable

    has_paper_trail

    belongs_to :alliance, optional: true

    # TODO: remove this
    # https://github.com/esi/esi-issues/blob/master/changelog.md#2021-10-21
    belongs_to :ancestry,
      primary_key: "ancestry_id",
      optional: true

    belongs_to :bloodline, optional: true

    belongs_to :corporation, optional: true

    belongs_to :faction,
      primary_key: "faction_id",
      optional: true

    belongs_to :race, optional: true

    has_many :character_corporation_histories, dependent: :destroy

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

    private

    def character_portrait_url(size)
      imageable_url("characters", id, "portrait", size)
    end
  end
end
