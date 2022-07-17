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

    # def inventions_available?
    #   # ID 688 - yes
    #   # ID 17637 - no
    #   blueprint_invention_products.present?
    # end
    #
    # def manufacturing_available?
    #   blueprint_manufacturing_products.present?
    # end
    #
    # def research_material_available?
    #   research_material_time.present?
    # end
    #
    # def research_time_available?
    #   research_time_time.present?
    # end
    #
    # def copying_available?
    #   copying_time.present?
    # end

    private

    def type_bp_url(size)
      imageable_url("types", id, "bp", size)
    end
  end
end
