# frozen_string_literal: true

# rubocop:disable Style/SignalException, Style/SpecialGlobalVars
namespace :factory_bot do
  desc "Verify that all FactoryBot factories are valid"
  task lint: :environment do
    if Rails.env.test?
      connection = ActiveRecord::Base.connection

      connection.transaction do
        DatabaseRewinder.clean_all

        FactoryBot.lint(traits: true)

        raise ActiveRecord::Rollback
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")

      fail if $?.exitstatus.nonzero?
    end
  end
end
# rubocop:enable Style/SignalException, Style/SpecialGlobalVars
