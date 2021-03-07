# frozen_string_literal: true

module Eve
  class BlueprintManufacturingSkillRecord < ApplicationRecord
    # belongs_to :blueprint,
    #   class_name: "Eve::Blueprint",
    #   primary_key: "type_id"
    #
    # belongs_to :type,
    #   primary_key: "type_id",
    #   optional: true
  end
end
