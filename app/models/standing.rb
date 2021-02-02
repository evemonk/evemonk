# frozen_string_literal: true

class Standing < ApplicationRecord
  has_paper_trail

  belongs_to :character

  belongs_to :standingable,
    polymorphic: true,
    optional: true

  # TODO: later
  # scope :factions_standings, -> do
  #   joins("LEFT JOIN eve_factions ON standings.standingable_id = eve_factions.id")
  #     .where(standingable_type: "Eve::Faction")
  #     .order("eve_factions.name_en": :asc)
  #     .includes(:standingable)
  # end
  #
  # scope :corporations_standings, -> do
  #   joins("LEFT JOIN eve_corporations ON standings.standingable_id = eve_corporations.id")
  #     .where(standingable_type: "Eve::Corporation")
  #     .order("eve_corporations.name": :asc)
  #     .includes(:standingable)
  # end
  #
  # scope :agents_standings, -> do
  #   joins("LEFT JOIN eve_agents ON standings.standingable_id = eve_agents.id")
  #     .where(standingable_type: "Eve::Agent")
  #     .order("eve_agents.name": :asc)
  #     .includes(:standingable)
  # end

  def rounded_standing
    standing.round(1)
  end
end
