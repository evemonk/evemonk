# frozen_string_literal: true

module Eve
  class UpdateMarketGroupsJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform
      Eve::MarketGroupsImporter.new.import
    end
  end
end
