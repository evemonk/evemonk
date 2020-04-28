# frozen_string_literal: true

class CharacterAssetsJob < ActiveJob::Base
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    OpenSSL::SSL::SSLError,
    Faraday::TimeoutError,
    Faraday::ConnectionFailed

  def perform(character_id, page = 1)
    CharacterAssetsImporter.new(character_id, page).import
  end
end
