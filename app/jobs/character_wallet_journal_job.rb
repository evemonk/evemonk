# frozen_string_literal: true

class CharacterWalletJournalJob < ActiveJob::Base
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    OpenSSL::SSL::SSLError,
    Faraday::TimeoutError,
    Faraday::ConnectionFailed

  def perform(character_id, page = 1)
    CharacterWalletJournalImporter.new(character_id, page).import
  end
end
