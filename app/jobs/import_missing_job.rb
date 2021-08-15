# frozen_string_literal: true

class ImportMissingJob < ApplicationJob
  queue_as :default

  def perform
    ImportMissing.new.import
  end
end
