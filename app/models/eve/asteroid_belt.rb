# frozen_string_literal: true

module Eve
  class AsteroidBelt < ApplicationRecord
    has_paper_trail

    has_one :position, as: :positionable, dependent: :destroy
  end
end
