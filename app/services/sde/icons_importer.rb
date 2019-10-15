# frozen_string_literal: true

module Sde
  class IconsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      # entries.each_pair do |key, value|
      #   icon = Eve::Icon.find_  by(icon_id: key)
      # end

      # => [["backgrounds", "description", "iconFile"],
      #     ["description", "iconFile"],
      #     ["backgrounds", "description", "foregrounds", "iconFile"],
      #     ["description", "foregrounds", "iconFile"],
      #     ["iconFile"],
      #     ["description", "iconFile", "obsolete"],
      #     ["foregrounds", "iconFile"]]

      # content.keys
      #
      # keys = content.values.map { |val| val.keys if val.is_a?(Hash) }
      #
      # keys.uniq
    end
  end
end
