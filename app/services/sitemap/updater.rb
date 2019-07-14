# frozen_string_literal: true

module Sitemap
  class Updater
    def update
      SitemapGenerator::Interpreter.run(verbose: false)

      FileUtils.mkdir_p('/shared')

      FileUtils.rm(Dir.glob('/shared/*.xml.gz'))

      FileUtils.cp(Dir.glob('public/*.xml.gz'), '/shared')

      SitemapGenerator::Sitemap.ping_search_engines
    end
  end
end
