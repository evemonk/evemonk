# frozen_string_literal: true

module Sde
  class AgentNamesJob < ApplicationJob
    queue_as :default

    def perform(file)
      AgentNamesImporter.new(file).import
    end
  end
end
