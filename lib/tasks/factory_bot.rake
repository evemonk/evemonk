# frozen_string_literal: true

namespace :factory_bot do
  desc "Verify that all FactoryBot factories are valid"
  task lint: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.strategy = :deletion
        DatabaseCleaner.clean

        FactoryBot.lint(traits: true)
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bundle exec rails factory_bot:lint RAILS_ENV=test")
    end
  end
end
