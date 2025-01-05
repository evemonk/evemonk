# frozen_string_literal: true

module Eve
  class UpdateGroupsJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(page = 1)
      Eve::GroupsImporter.new(page).import
    end
  end
end
