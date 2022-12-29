# frozen_string_literal: true

module Eve
  class Ancestry < ApplicationRecord
    self.primary_key = "ancestry_id"

    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :bloodline, optional: true

    belongs_to :icon,
      primary_key: "icon_id",
      optional: true
  end
end
