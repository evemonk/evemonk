# frozen_string_literal: true

module Maintenance
  # Refresh sitemaps, upload to S3 Bucket and ping Google.
  class SitemapUpdaterTask < MaintenanceTasks::Task
    no_collection

    def process
      SitemapUpdaterJob.perform_later
    end
  end
end
