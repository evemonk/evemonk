# frozen_string_literal: true

module Eve
  class Blueprint < Type
    default_scope { where(is_blueprint: true) }

    has_many :blueprint_invention_materials,
      primary_key: "type_id",
      dependent: :destroy

    has_many :blueprint_invention_products,
      primary_key: "type_id",
      dependent: :destroy

    has_many :blueprint_invention_skills,
      primary_key: "type_id",
      dependent: :destroy

    has_many :blueprint_manufacturing_materials,
      primary_key: "type_id",
      dependent: :destroy

    has_many :blueprint_manufacturing_products,
      primary_key: "type_id",
      dependent: :destroy

    has_many :blueprint_manufacturing_skills,
      primary_key: "type_id",
      dependent: :destroy
  end
end
