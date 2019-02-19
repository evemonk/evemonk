# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://evemonk.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/'
  add '/sign_in'
  add '/sign_up'
  add '/forgot_password'

  add '/universe/alliances'

  pages = Eve::Alliance.page(1).total_pages

  (1..pages).each do |page|
    add "/universe/alliances?page=#{ page }"
  end

  Eve::Alliance.find_each do |alliance|
    add "/universe/alliances/#{ alliance.alliance_id }"
    add "/universe/alliances/#{ alliance.alliance_id }/characters"
    add "/universe/alliances/#{ alliance.alliance_id }/corporations"

    pages = alliance.characters.page(1).total_pages

    (1..pages).each do |page|
      add "/universe/alliances/#{ alliance.alliance_id }/characters?page=#{ page }"
    end

    pages = alliance.corporations.page(1).total_pages

    (1..pages).each do |page|
      add "/universe/alliances/#{ alliance.alliance_id }/corporations?page=#{ page }"
    end
  end
end
