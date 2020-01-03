# frozen_string_literal: true

module Eve
  class Position < ApplicationRecord
    belongs_to :positionable, polymorphic: true
  end
end
