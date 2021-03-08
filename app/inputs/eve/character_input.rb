# frozen_string_literal: true

module Eve
  class CharacterInput < Upgrow::Input
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

    validates :character_id, presence: true
    validates :birthday, presence: true
    validates :bloodline_id, presence: true
    validates :corporation_id, presence: true
    validates :gender, presence: true
    validates :name, presence: true
    validates :race_id, presence: true
  end
end
