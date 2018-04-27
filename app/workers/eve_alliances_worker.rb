# frozen_string_literal: true

require 'sidekiq-scheduler'

class EveAlliancesWorker
  include Sidekiq::Worker

  def perform
    AlliancesImporter.new.import
  end
end
