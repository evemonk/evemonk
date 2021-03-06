# frozen_string_literal: true

module Eve
  class BlueprintInventionMaterial < ApplicationRecord
    belongs_to :blueprint,
      class_name: "Eve::Blueprint",
      primary_key: "type_id"
  end
end
