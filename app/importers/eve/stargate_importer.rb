# frozen_string_literal: true

module Eve
  class StargateImporter < BaseImporter
    attr_reader :stargate_id

    def initialize(stargate_id)
      @stargate_id = stargate_id
    end

    def import
      import! do
        eve_stargate = Eve::Stargate.find_or_initialize_by(id: stargate_id)

        eve_stargate.update!(esi.as_json)

        eve_stargate.position&.destroy

        eve_stargate.create_position!(esi.position.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Stargate ID #{stargate_id}")

        eve_stargate.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseStargate.new(stargate_id: stargate_id)
    end
  end
end
