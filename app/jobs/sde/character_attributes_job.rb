# frozen_string_literal: true

module Sde
  class CharacterAttributesJob < ApplicationJob
    queue_as :default

    def perform(file)
      CharacterAttributesImporter.new(file).import
    end
  end
end
