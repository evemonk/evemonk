# frozen_string_literal: true

module Eve
  class Corporation < ApplicationRecord
    self.primary_key = "corporation_id"

    include PgSearch::Model
    include ActionView::Helpers::NumberHelper
    include Imageable

    has_paper_trail

    belongs_to :alliance, optional: true

    belongs_to :ceo, class_name: "Eve::Character", optional: true

    belongs_to :creator, class_name: "Eve::Character", optional: true

    belongs_to :faction, optional: true

    belongs_to :home_station, class_name: "Eve::Station", optional: true

    has_many :characters

    has_many :corporation_alliance_histories

    has_many :standings, as: :standingable

    has_many :loyalty_store_offers,
      primary_key: "corporation_id"

    scope :npc, -> { where(npc: true) }

    scope :not_npc, -> { where(npc: false) }

    after_commit :eve_alliance_reset_corporations_count, on: [:create, :update, :destroy]

    after_commit :eve_alliance_reset_characters_count, on: [:create, :update, :destroy]

    pg_search_scope :search_by_name_and_ticker, against: [:name, :ticker]

    has_one_attached :logo

    def eve_alliance_reset_corporations_count
      alliance&.reset_corporations_count
    end

    def eve_alliance_reset_characters_count
      alliance&.reset_characters_count
    end

    def icon_tiny
      corporation_logo_url(32)
    end

    def icon_small
      corporation_logo_url(64)
    end

    def icon_medium
      corporation_logo_url(128)
    end

    def icon_large
      corporation_logo_url(256)
    end

    def formatted_member_count
      number_with_delimiter(member_count, delimiter: ",")
    end

    def sanitized_description
      Rails::Html::FullSanitizer.new.sanitize(description)
    end

    private

    def corporation_logo_url(size)
      imageable_url("corporations", corporation_id, "logo", size)
    end
  end
end
