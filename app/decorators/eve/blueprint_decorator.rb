# frozen_string_literal: true

module Eve
  class BlueprintDecorator < TypeDecorator
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

    def time_to_human_time_formatted(time)
      case time
      when 0..60
        "#{time} seconds"
      when 61..3600
        "#{time / 60} minutes"
      when 3601..86400
        "#{time / 60 / 60} hours"
      else
        "#{time / 60 / 60 / 24} days"
      end
    end
  end
end
