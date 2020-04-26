# frozen_string_literal: true

module Eve
  class BlueprintDecorator < TypeDecorator
    decorates_associations :blueprint_invention_materials,
      :blueprint_invention_products, :blueprint_invention_skills,
      :blueprint_manufacturing_materials, :blueprint_manufacturing_products,
      :blueprint_manufacturing_skills

    def copying_time_formatted
      HumanTime.new(copying_time).long_formatted
    end

    # def time_copying_modifier
    #   27.11
    # end

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=64"
    end
  end
end
