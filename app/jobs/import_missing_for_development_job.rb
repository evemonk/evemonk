# frozen_string_literal: true

class ImportMissingForDevelopmentJob < ApplicationJob
  queue_as :default

  def perform
    ImportMissingForDevelopment.new.import
  end
end
