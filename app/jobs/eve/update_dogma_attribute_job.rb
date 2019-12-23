# frozen_string_literal: true

module Eve
  class UpdateDogmaAttributeJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform(attribute_id)
      Eve::DogmaAttributeImporter.new(attribute_id).import
    end
  end
end
