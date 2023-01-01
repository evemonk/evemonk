# frozen_string_literal: true

module Eve
  class BlueprintInventionSkill < ApplicationRecord
    belongs_to :blueprint

    belongs_to :type, optional: true
  end
end
