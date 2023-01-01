# frozen_string_literal: true

module Eve
  class BlueprintManufacturingProduct < ApplicationRecord
    belongs_to :blueprint

    belongs_to :type, optional: true
  end
end
