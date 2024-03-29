# frozen_string_literal: true

class Standing < ApplicationRecord
  belongs_to :character

  belongs_to :standingable,
    polymorphic: true,
    optional: true

  belongs_to :faction, -> { where(standings: {standingable_type: Eve::Faction.name}) },
    foreign_key: "standingable_id",
    class_name: "Eve::Faction",
    inverse_of: :standings,
    optional: true

  belongs_to :corporation, -> { where(standings: {standingable_type: Eve::Corporation.name}) },
    foreign_key: "standingable_id",
    class_name: "Eve::Corporation",
    inverse_of: :standings,
    optional: true

  belongs_to :agent, -> { where(standings: {standingable_type: Eve::Agent.name}) },
    foreign_key: "standingable_id",
    class_name: "Eve::Agent",
    inverse_of: :standings,
    optional: true

  scope :factions, -> do
    where(standings: {standingable_type: Eve::Faction.name})
      .order("eve_factions.name_en ASC")
  end

  scope :corporations, -> do
    where(standings: {standingable_type: Eve::Corporation.name})
      .order("eve_corporations.name ASC")
  end

  scope :agents, -> do
    where(standings: {standingable_type: Eve::Agent.name})
      .order("eve_agents.name ASC")
  end

  def rounded_standing
    standing.round(1).to_s
  end
end
