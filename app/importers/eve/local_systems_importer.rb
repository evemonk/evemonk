# frozen_string_literal: true

module Eve
  class LocalSystemsImporter
    def import
      Eve::System.pluck(:id).each do |system_id|
        Eve::UpdateSystemJob.perform_later(system_id)
      end
    end
  end
end
