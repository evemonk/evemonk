namespace :factory_girl do
  desc 'Verify that all FactoryGirl factories are valid'
  task lint: :environment do
    if Rails.env.test?
      begin
        DatabaseRewinder.clean_all

        FactoryGirl.lint(traits: true)
      ensure
        DatabaseRewinder.clean_all
      end
    else
      system('bundle exec rails factory_girl:lint RAILS_ENV=test')
    end
  end
end
