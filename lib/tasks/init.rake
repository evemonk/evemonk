# frozen_string_literal: true

namespace :evemonk do
  task init: :environment do
    Eve::UpdateRacesJob.new.perform
    Eve::UpdateFactionsJob.new.perform
    Eve::UpdateBloodlinesJob.new.perform
    Eve::UpdateAncestriesJob.new.perform
  end
end
