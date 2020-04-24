# frozen_string_literal: true

module Sde
  class BlueprintsJob < ActiveJob::Base
    queue_as :default

    def perform(file)
      BlueprintsImporter.new(file).import

      BlueprintsInventionMaterialsImporter.new(file).import
    end
  end
end
