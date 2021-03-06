# frozen_string_literal: true

module Eve
  class Alliance < Upgrow::Model
    attribute :alliance_id
    attribute :creator_corporation_id
    attribute :creator_id
    attribute :date_founded
    attribute :executor_corporation_id
    attribute :faction_id
    attribute :name
    attribute :ticker
    attribute :corporations_count
    attribute :characters_count
  end
end
