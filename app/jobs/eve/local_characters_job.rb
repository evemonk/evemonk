# frozen_string_literal: true

module Eve
  class LocalCharactersJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform
      Eve::LocalCharactersImporter.new.import
    end
  end
end
