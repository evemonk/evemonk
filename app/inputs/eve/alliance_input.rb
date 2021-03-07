# frozen_string_literal: true

module Eve
  class AllianceInput < Upgrow::Input
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

    validates :alliance_id, presence: true
    validates :creator_corporation_id, presence: true
    validates :creator_id, presence: true
    validates :date_founded, presence: true
    validates :name, presence: true
    validates :ticker, presence: true
  end
end
