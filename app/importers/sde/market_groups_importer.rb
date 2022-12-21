# frozen_string_literal: true

module Sde
  class MarketGroupsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        market_group = Eve::MarketGroup.find_or_initialize_by(market_group_id: key)

        market_group.assign_attributes(has_types: hash["hasTypes"],
          icon_id: hash["iconID"])

        market_group.save!
      end
    end
  end
end
