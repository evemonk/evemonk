# frozen_string_literal: true

module Eve
  class StargateImporter
    attr_reader :stargate_id

    def initialize(stargate_id)
      @stargate_id = stargate_id
    end

    def import
      eve_stargate = Eve::Stargate.find_or_initialize_by(stargate_id: stargate_id)

      stargate = EveOnline::ESI::UniverseStargate.new(id: stargate_id, etag: eve_stargate.etag)

      return if stargate.no_content?

      eve_stargate.assign_attributes(stargate.as_json.merge(etag: stargate.current_etag))

      # TODO: add stargate destination
      # TODO: add stargate position

      eve_stargate.save! if eve_stargate.changed?
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_stargate.destroy if eve_stargate.persisted?
    end
  end
end
