# frozen_string_literal: true

class ImportMissingForDevelopmentJob < ApplicationJob
  queue_as :default

  def perform
    ImportMissing::ForDevelopment.new.import
  end
end
