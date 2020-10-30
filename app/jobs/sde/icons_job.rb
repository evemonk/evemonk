# frozen_string_literal: true

module Sde
  class IconsJob < ApplicationJob
    queue_as :default

    def perform(file)
      IconsImporter.new(file).import
    end
  end
end
