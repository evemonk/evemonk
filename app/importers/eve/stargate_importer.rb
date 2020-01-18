# frozen_string_literal: true

module Eve
  class StargateImporter
    attr_reader :stargate_id

    def initialize(stargate_id)
      @stargate_id = stargate_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_stargate = Eve::Stargate.find_or_initialize_by(stargate_id: stargate_id)

        esi = EveOnline::ESI::UniverseStargate.new(id: stargate_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_stargate.update!(esi.as_json)

        eve_stargate.position&.destroy

        eve_stargate.create_position!(esi.position.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_stargate.destroy!
      end
    end
  end
end
