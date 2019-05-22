# frozen_string_literal: true

module Eve
  class SystemsImporter
    def import
      system_ids = EveOnline::ESI::UniverseSystems.new.universe_system_ids

      system_ids.each do |system_id|
        Eve::SystemImporterWorker.perform_async(system_id)
      end
    end
  end
end
