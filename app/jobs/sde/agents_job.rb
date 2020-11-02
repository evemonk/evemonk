# frozen_string_literal: true

module Sde
  class AgentsJob < ApplicationJob
    queue_as :default

    def perform(file)
      AgentsImporter.new(file).import
    end
  end
end
