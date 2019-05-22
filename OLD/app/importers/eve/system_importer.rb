# frozen_string_literal: true

module Eve
  class SystemImporter
    attr_reader :system_id

    def initialize(system_id)
      @system_id = system_id
    end

    def import
      eve_system = Eve::System.find_or_initialize_by(system_id: system_id)

      system = EveOnline::ESI::UniverseSystem.new(id: system_id)

      eve_system.assign_attributes(system.as_json)

      # TODO: import system position
      # TODO: import system planets
      # TODO: import planet asteroid belts
      # TODO: import system moons
      # TODO: import system stations

      system.stargate_ids.each do |stargate_id|
        Eve::StargateImporterWorker.perform_async(stargate_id)
      end

      eve_system.save! if eve_system.changed?
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_system.destroy if eve_system.persisted?
    end
  end
end
