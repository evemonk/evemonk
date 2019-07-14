# frozen_string_literal: true

class SitemapUpdaterWorker
  include Sidekiq::Worker

  def perform
    Sitemap::Updater.new.update
  end
end
