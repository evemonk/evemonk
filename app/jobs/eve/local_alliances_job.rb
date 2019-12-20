# frozen_string_literal: true

module Eve
  class LocalAlliancesJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform
      Eve::LocalAlliancesImporter.new.import
    end
  end
end
