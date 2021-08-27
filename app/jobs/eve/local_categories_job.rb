# frozen_string_literal: true

module Eve
  class LocalCategoriesJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalCategoriesImporter.new.import
    end
  end
end
