# frozen_string_literal: true

module Sitemap
  class Updater
    def update
      SitemapGenerator::Interpreter.run(verbose: false)

      FileUtils.mkdir_p("/shared/public/")

      FileUtils.rm(Dir.glob("/shared/public/*.xml.gz"))

      FileUtils.cp(Dir.glob("public/*.xml.gz"), "/shared/public/")

      SitemapGenerator::Sitemap.ping_search_engines
    end
  end
end
