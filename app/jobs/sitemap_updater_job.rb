# frozen_string_literal: true

class SitemapUpdaterJob < ActiveJob::Base
  queue_as :default

  def perform
    Sitemap::Updater.new.update
  end
end
