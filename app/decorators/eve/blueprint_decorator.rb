# frozen_string_literal: true

module Eve
  class BlueprintDecorator < TypeDecorator
    decorates_associations :blueprint_invention_materials,
      :blueprint_invention_products, :blueprint_invention_skills,
      :blueprint_manufacturing_materials, :blueprint_manufacturing_products,
      :blueprint_manufacturing_skills

    def copying_time_formatted
      time_to_human_time_formatted(copying_time)
    end

    def manufacturing_time_formatted
      time_to_human_time_formatted(manufacturing_time)
    end

    def research_material_time_formatted
      time_to_human_time_formatted(research_material_time)
    end

    def research_time_time_formatted
      time_to_human_time_formatted(research_time_time)
    end

    def invention_time_formatted
      time_to_human_time_formatted(invention_time)
    end

    private

    def time_to_human_time_formatted(seconds)
      case seconds
      when 0..60
        "#{seconds} seconds"
      when 61..3600
        "#{seconds / 60} minutes"
      when 3601..86_400
        "#{seconds / 60 / 60} hours"
      else
        "#{seconds / 60 / 60 / 24} days"
      end
    end
  end
end
