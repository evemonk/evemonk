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

  add graphiql_rails_path

  add faq_path

  add new_user_session_path
  add new_user_registration_path
  add new_user_password_path
  add new_user_confirmation_path

  add universe_alliances_path

  pages = Eve::Alliance.page(1).total_pages

  (1..pages).each do |page|
    add universe_alliances_path(path: page)
  end

  Eve::Alliance.find_each do |alliance|
    add universe_alliance_path(alliance)
  end

  add universe_corporations_path

  pages = Eve::Corporation.page(1).total_pages

  (1..pages).each do |page|
    add universe_corporations_path(path: page)
  end

  Eve::Corporation.find_each do |corporation|
    add universe_corporation_path(corporation)
  end

  add universe_characters_path

  pages = Eve::Character.page(1).total_pages

  (1..pages).each do |page|
    add universe_characters_path(path: page)
  end

  Eve::Character.find_each do |character|
    add universe_character_path(character)
  end

  #               universe_categories GET    /universe/categories(.:format)                                                                    universe/categories#index
  #                 universe_category GET    /universe/categories/:id(.:format)                                                                universe/categories#show
  #                    universe_group GET    /universe/groups/:id(.:format)                                                                    universe/groups#show
  #            universe_market_groups GET    /universe/market_groups(.:format)                                                                 universe/market_groups#index
  #             universe_market_group GET    /universe/market_groups/:id(.:format)                                                             universe/market_groups#show
  #                     universe_type GET    /universe/types/:id(.:format)                                                                     universe/types#show
  #             universe_search_index GET    /universe/search(.:format)                                                                        universe/search#index
  #       blueprints_calculator_index GET    /blueprints/calculator(.:format)                                                                  blueprints/calculator#index
  #             blueprints_calculator GET    /blueprints/calculator/:id(.:format)                                                              blueprints/calculator#show
  #       api_eve_manufacturing_items GET    /api/eve/manufacturing_items(.:format)                                                            api/eve/manufacturing_items#index {:format=>"json"}
end
