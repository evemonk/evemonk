# frozen_string_literal: true

module Eve
  class Ancestry < ApplicationRecord
    extend Mobility

    translates :name, :description

    belongs_to :bloodline, optional: true

    belongs_to :icon, optional: true
  end
end
