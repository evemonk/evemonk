# frozen_string_literal: true

class CharacterBlueprintsJob < ApplicationJob
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    Faraday::TimeoutError,
    Faraday::ConnectionFailed

  discard_on CharacterInvalidToken

  def perform(character_id, page = 1)
    CharacterBlueprintsImporter.new(character_id, page).import
  end
end
