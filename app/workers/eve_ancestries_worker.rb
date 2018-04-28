# frozen_string_literal: true

require 'sidekiq-scheduler'

class EveAncestriesWorker
  include Sidekiq::Worker

  def perform
    AncestriesImporter.new.import
  end
end
