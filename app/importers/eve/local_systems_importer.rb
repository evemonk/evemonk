# frozen_string_literal: true

# TODO: update
module Eve
  class LocalSystemsImporter
    def import
      Eve::System.pluck(:system_id).each do |system_id|
        Eve::UpdateSystemJob.perform_later(system_id)
      end
    end
  end
end
