# frozen_string_literal: true

module Eve
  class CorporationMembersJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    discard_on CharacterInvalidToken

    def perform(character_id)
      Eve::CorporationMembersImporter.new(character_id).import
    end
  end
end
