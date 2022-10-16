# frozen_string_literal: true

class ImportMissingJob < ApplicationJob
  queue_as :default

  def perform
    if Flipper.enabled?(:import_missing_job)
      ImportMissing::Everything.new.import
    end
  end
end
