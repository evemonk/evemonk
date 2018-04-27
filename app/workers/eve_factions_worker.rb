# frozen_string_literal: true

require 'sidekiq-scheduler'

class EveFactionsWorker
  include Sidekiq::Worker

  def perform
    FactionsImporter.new.import
  end
end
