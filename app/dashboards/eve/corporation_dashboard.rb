# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class CorporationDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      alliance: Field::BelongsTo,
      ceo: Field::BelongsTo,
      creator: Field::BelongsTo,
      date_founded: Field::DateTime,
      description: Field::Text,
      faction: Field::BelongsTo,
      home_station: Field::BelongsTo,
      member_count: Field::Number,
      name: Field::String,
      shares: Field::Number,
      tax_rate: Field::Number,
      ticker: Field::String,
      corporation_url: Field::String,
      war_eligible: Field::Boolean,
      npc: Field::Boolean,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :alliance,
      :ceo,
      :creator,
      :date_founded,
      :description,
      :faction,
      :home_station,
      :member_count,
      :name,
      :shares,
      :tax_rate,
      :ticker,
      :corporation_url,
      :war_eligible,
      :npc,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(corporation)
      corporation.name
    end
  end
end
