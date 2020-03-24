# frozen_string_literal: true

module Eve
  class Ancestry < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :bloodline,
      primary_key: "bloodline_id",
      optional: true

    # belongs_to :icon_id
  end
end
