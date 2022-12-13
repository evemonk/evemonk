# frozen_string_literal: true

module Eve
  class AllianceEntity < BaseEntity
    attributes :id, :alliance_id, :creator_corporation_id, :creator_id,
               :date_founded, :executor_corporation_id, :faction_id, :name,
               :ticker, :corporations_count, :characters_count, :created_at,
               :updated_at
  end
end
