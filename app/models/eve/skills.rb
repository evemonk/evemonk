# frozen_string_literal: true

module Eve
  class Skills
    SCIENCE_ID = 3402
    ADVANCED_INDUSTRY_ID = 3388

    class << self
      def science
        Eve::Type.published.find_by!(type_id: SCIENCE_ID)
      end

      def advanced_industry
        Eve::Type.published.find_by!(type_id: ADVANCED_INDUSTRY_ID)
      end
    end
  end
end
