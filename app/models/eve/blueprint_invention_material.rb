# frozen_string_literal: true

module Eve
  class BlueprintInventionMaterial < ApplicationRecord
    belongs_to :blueprint

    belongs_to :type, optional: true
  end
end
