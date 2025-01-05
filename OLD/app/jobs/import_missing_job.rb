# frozen_string_literal: true

class ImportMissingJob < ApplicationJob
  queue_as :default

  def perform
    if Rails.configuration.evemonk.jobs[:import_missing]
      ImportMissing::Everything.new.import
    end
  end
end
