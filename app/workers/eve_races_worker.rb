# frozen_string_literal: true

require 'sidekiq-scheduler'

class EveRacesWorker
  include Sidekiq::Worker

  def perform
    RacesImporter.new.import
  end
end
