# frozen_string_literal: true

module Sitemap
  class Updater
    def update
      SitemapGenerator::Interpreter.run(verbose: false)

      SitemapGenerator::Sitemap.ping_search_engines
    end
  end
end
