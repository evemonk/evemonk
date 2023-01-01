# frozen_string_literal: true

module Eve
  class BlueprintManufacturingSkill < ApplicationRecord
    belongs_to :blueprint

    belongs_to :type, optional: true
  end
end
