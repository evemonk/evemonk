# frozen_string_literal: true

class CharacterStandingsJob < ApplicationJob
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    Faraday::TimeoutError,
    Faraday::ConnectionFailed

  discard_on CharacterInvalidToken

  def perform(character_id)
    if Rails.configuration.evemonk.jobs[:character][:standings]
      CharacterStandingsImporter.new(character_id).import
    end
  end
end
