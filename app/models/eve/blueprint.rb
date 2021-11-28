# frozen_string_literal: true

module Eve
  class Blueprint < Type
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
