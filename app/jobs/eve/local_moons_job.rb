# frozen_string_literal: true

module Eve
  class LocalMoonsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalMoonsImporter.new.import
    end
  end
end
