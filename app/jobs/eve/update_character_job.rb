# frozen_string_literal: true

module Eve
  class UpdateCharacterJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    # @param id [Integer] Eve::Character ID
    def perform(id)
      if Flipper.enabled?(:eve_character)
        Eve::CharacterImporter.new(id).import
      end
    end
  end
end
