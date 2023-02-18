# frozen_string_literal: true

module Eve
  class SystemsImporter < BaseImporter
    def import
      import! do
        import_new_systems

        remove_old_systems
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseSystems.new
    end

    private

    def import_new_systems
      eve_system_ids = Eve::System.pluck(:id)

      eve_system_ids_to_create = esi.universe_system_ids - eve_system_ids

      eve_system_ids_to_create.each do |system_id|
        Eve::UpdateSystemJob.perform_later(system_id)
      end
    end

    def remove_old_systems
      eve_system_ids = Eve::System.pluck(:id)

      eve_system_ids_to_remove = eve_system_ids - esi.universe_system_ids

      eve_system_ids_to_remove.each do |system_id|
        eve_system = Eve::System.find_or_initialize_by(id: system_id)

        eve_system.destroy!
      end
    end
  end
end
