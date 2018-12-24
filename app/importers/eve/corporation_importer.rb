# frozen_string_literal: true

module Eve
  class CorporationImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      eve_corporation = Eve::Corporation.find_or_initialize_by(corporation_id: corporation_id)

      corporation = EveOnline::ESI::Corporation.new(corporation_id: corporation_id)

      eve_corporation.assign_attributes(corporation.as_json)

      eve_corporation.save! if eve_corporation.changed?
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_corporation.destroy if eve_corporation.persisted?
    end
  end
end
