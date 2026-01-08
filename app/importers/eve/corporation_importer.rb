# frozen_string_literal: true

module Eve
  class CorporationImporter < BaseImporter
    attr_reader :id

    # @param id [Integer] Eve Corporation ID
    def initialize(id)
      @id = id
    end

    def import
      import! do
        eve_corporation = Eve::Corporation.find_or_initialize_by(id: id)

        eve_corporation.update!(corporation.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{id}")

        eve_corporation&.destroy!
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
    end

    def corporation
      @corporation ||= client.corporations.retrieve(id: id)
    end
  end
end
