# frozen_string_literal: true

module Eve
  class UpdateGroupJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(group_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::GroupImporter.new(group_id, locale).import
      end
    end
  end
end
