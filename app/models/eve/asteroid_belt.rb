# frozen_string_literal: true

module Eve
  class AsteroidBelt < ApplicationRecord
    has_paper_trail

    belongs_to :system, optional: true

    belongs_to :planet, optional: true

    has_one :position, as: :positionable, dependent: :destroy
  end
end
