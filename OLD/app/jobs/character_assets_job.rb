# frozen_string_literal: true

class CharacterAssetsJob < ApplicationJob
  queue_as :important

  retry_on EveOnline::Exceptions::Timeout,
    EveOnline::Exceptions::ServiceUnavailable,
    EveOnline::Exceptions::BadGateway,
    EveOnline::Exceptions::InternalServerError,
    Faraday::TimeoutError,
    Faraday::ConnectionFailed

  discard_on CharacterInvalidToken

  def perform(id, page = 1)
    if Rails.configuration.evemonk.jobs[:character][:assets]
      CharacterAssetsImporter.new(id, page).import
    end
  end
end
