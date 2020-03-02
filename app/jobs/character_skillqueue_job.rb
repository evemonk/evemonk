# frozen_string_literal: true

class CharacterSkillqueueJob < ActiveJob::Base
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    OpenSSL::SSL::SSLError,
    Faraday::Error::TimeoutError,
    Faraday::ConnectionFailed

  def perform(character_id)
    CharacterSkillqueueImporter.new(character_id).import
  end
end
