# frozen_string_literal: true

class ImportMissingJob < ApplicationJob
  queue_as :default

  def perform
    ImportMissing::Everything.new.import
  end
end
