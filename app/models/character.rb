# frozen_string_literal: true

class Character < ApplicationRecord
  belongs_to :user

  belongs_to :race, class_name: "Eve::Race", primary_key: :race_id, optional: true

  belongs_to :bloodline, class_name: "Eve::Bloodline", primary_key: :bloodline_id, optional: true

  belongs_to :faction, class_name: "Eve::Faction", primary_key: :faction_id, optional: true

  belongs_to :ancestry, class_name: "Eve::Ancestry", primary_key: :ancestry_id, optional: true

  belongs_to :alliance, class_name: "Eve::Alliance", primary_key: :alliance_id, optional: true

  belongs_to :corporation, class_name: "Eve::Corporation", primary_key: :corporation_id, optional: true

  has_many :loyalty_points, dependent: :destroy

  has_many :character_assets, dependent: :destroy

  has_many :character_implants, dependent: :destroy

  has_many :implants, through: :character_implants

  has_many :skillqueues, dependent: :destroy

  has_many :skills, dependent: :destroy

  def token_expired?
    token_expires_at <= Time.zone.now
  end
end
