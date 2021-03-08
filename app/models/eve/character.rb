# frozen_string_literal: true

module Eve
  class Character < Upgrow::Model
    attribute :character_id
    attribute :alliance_id
    attribute :ancestry_id
    attribute :birthday
    attribute :bloodline_id
    attribute :corporation_id
    attribute :description
    attribute :faction_id
    attribute :gender
    attribute :name
    attribute :race_id
    attribute :security_status
    attribute :title
  end
end
