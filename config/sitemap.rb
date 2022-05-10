# frozen_string_literal: true

require "aws-sdk-s3"

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://evemonk.com"

SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV.fetch("BUCKET", nil),
  aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID", nil),
  aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY", nil),
  aws_region: ENV.fetch("MINIO_REGION_NAME", nil),
  aws_endpoint: ENV.fetch("MINIO_ENDPOINT", nil)
)

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

  add "/"
  # add "/sign_in"
  # add "/sign_up"
  # add "/forgot_password"

  add "/universe/alliances"

  pages = Eve::Alliance.page(1).total_pages

  (1..pages).each do |page|
    add "/universe/alliances?page=#{page}"
  end

  Eve::Alliance.pluck(:alliance_id).each do |alliance_id|
    add "/universe/alliances/#{alliance_id}"
  end

  add "/universe/corporations"

  pages = Eve::Corporation.page(1).total_pages

  (1..pages).each do |page|
    add "/universe/corporations?page=#{page}"
  end

  Eve::Corporation.pluck(:corporation_id).each do |corporation_id|
    add "/universe/corporations/#{corporation_id}"
  end

  add "universe/characters"

  pages = Eve::Character.page(1).total_pages

  (1..pages).each do |page|
    add "/universe/characters?page=#{page}"
  end

  Eve::Character.pluck(:character_id).each do |character_id|
    add "/universe/characters/#{character_id}"
  end
end
