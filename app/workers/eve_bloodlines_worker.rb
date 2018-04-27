# frozen_string_literal: true

require 'sidekiq-scheduler'

class EveBloodlinesWorker
  include Sidekiq::Worker

  def perform
    BloodlinesImporter.new.import
  end
end
