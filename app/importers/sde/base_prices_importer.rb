# frozen_string_literal: true

module Sde
  class BasePricesImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        eve_type = Eve::Type.find_or_initialize_by(type_id: key)

        eve_type.assign_attributes(base_price: hash["basePrice"])

        eve_type.save!
      end
    end
  end
end
