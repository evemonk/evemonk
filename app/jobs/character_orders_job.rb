# frozen_string_literal: true

class CharacterOrdersJob < ActiveJob::Base
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    OpenSSL::SSL::SSLError,
    Faraday::TimeoutError,
    Faraday::ConnectionFailed

  def perform(character_id)
    CharacterOrdersImporter.new(character_id).import
  end
end
