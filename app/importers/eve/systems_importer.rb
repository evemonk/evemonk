# frozen_string_literal: true

module Eve
  class SystemsImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::UniverseSystems.new
    end

    def import
      ActiveRecord::Base.transaction do
        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_systems

        remove_old_systems

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def import_new_systems
      eve_system_ids = Eve::System.pluck(:system_id)

      eve_system_ids_to_create = esi.universe_system_ids - eve_system_ids

      eve_system_ids_to_create.each do |system_id|
        Eve::UpdateSystemJob.perform_later(system_id)
      end
    end

    def remove_old_systems
      eve_system_ids = Eve::System.pluck(:system_id)

      eve_system_ids_to_remove = eve_system_ids - esi.universe_system_ids

      eve_system_ids_to_remove.each do |system_id|
        eve_system = Eve::System.find_or_initialize_by(system_id: system_id)

        eve_system.destroy!
      end
    end
  end
end
