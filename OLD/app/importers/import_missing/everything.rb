# frozen_string_literal: true

module ImportMissing
  class Everything
    def import
      Alliances.new.import

      Corporations.new.import

      Ships.new.import

      Stations.new.import

      Systems.new.import
    end
  end
end
