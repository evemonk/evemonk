# frozen_string_literal: true

module Eve
  class Blueprint < Type
    has_many :blueprint_invention_materials, dependent: :destroy

    has_many :blueprint_invention_products, dependent: :destroy

    has_many :blueprint_invention_skills, dependent: :destroy

    has_many :blueprint_manufacturing_materials, dependent: :destroy

    has_many :blueprint_manufacturing_products, dependent: :destroy

    has_many :blueprint_manufacturing_skills, dependent: :destroy

    def copying_time_formatted
      HumanTime.new(copying_time).long_formatted
    end

    # def time_copying_modifier
    #   27.11
    # end

    def icon_tiny
      type_bp_url(32)
    end

    def icon_small
      type_bp_url(64)
    end

    private

    def type_bp_url(size)
      imageable_url("types", type_id, "bp", size)
    end
  end
end
