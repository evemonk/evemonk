# frozen_string_literal: true

module Eve
  class Constellation < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    has_one :position, as: :positionable, dependent: :destroy
  end
end
