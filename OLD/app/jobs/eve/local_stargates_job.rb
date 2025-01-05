# frozen_string_literal: true

module Eve
  class LocalStargatesJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalStargatesImporter.new.import
    end
  end
end
