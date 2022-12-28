# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    self.primary_key = "race_id"

    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :faction, optional: true

    has_many :bloodlines

    has_many :stations
  end
end
