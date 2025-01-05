# frozen_string_literal: true

module Eve
  class UpdateDogmaAttributeJob < ApplicationJob
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      Faraday::TimeoutError,
      Faraday::ConnectionFailed

    def perform(attribute_id)
      Eve::DogmaAttributeImporter.new(attribute_id).import
    end
  end
end
