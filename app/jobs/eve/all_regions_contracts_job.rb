# frozen_string_literal: true

module Eve
  class AllRegionsContractsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::AllRegionsContractsImporter.new.import
    end
  end
end
