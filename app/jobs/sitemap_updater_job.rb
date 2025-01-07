# frozen_string_literal: true

class SitemapUpdaterJob < ApplicationJob
  queue_as :default

  def perform
    Sitemap::Updater.new.update
  end
end
