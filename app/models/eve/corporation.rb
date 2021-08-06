# frozen_string_literal: true

module Eve
  class Corporation < ApplicationRecord
    include ActionView::Helpers::NumberHelper
    include ImageProxy

    has_paper_trail

    belongs_to :alliance,
      primary_key: "alliance_id",
      optional: true

    belongs_to :ceo,
      primary_key: "character_id",
      class_name: "Eve::Character",
      optional: true

    belongs_to :creator,
      primary_key: "character_id",
      class_name: "Eve::Character",
      optional: true

    belongs_to :faction,
      primary_key: "faction_id",
      optional: true

    belongs_to :home_station,
      class_name: "Eve::Station",
      primary_key: "station_id",
      foreign_key: "home_station_id",
      optional: true

    has_many :characters,
      primary_key: "corporation_id"

    has_many :corporation_alliance_histories,
      primary_key: "corporation_id"

    has_many :standings, as: :standingable

    has_many :loyalty_store_offers,
      primary_key: "corporation_id"

    scope :npc, -> { where(npc: true) }

    scope :not_npc, -> { where(npc: false) }

    after_commit :eve_alliance_reset_corporations_count, on: [:create, :update, :destroy]

    after_commit :eve_alliance_reset_characters_count, on: [:create, :update, :destroy]

    # TODO: write new search
    # def search_data
    #   {
    #     name: name,
    #     ticker: ticker
    #   }
    # end

    def eve_alliance_reset_corporations_count
      alliance&.reset_corporations_count
    end

    def eve_alliance_reset_characters_count
      alliance&.reset_characters_count
    end

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=128"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=256"
    end

    def formatted_member_count
      number_with_delimiter(member_count, delimiter: ",")
    end

    def sanitized_description
      Rails::Html::FullSanitizer.new.sanitize(description)
    end
  end
end
