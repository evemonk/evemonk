# frozen_string_literal: true

module Eve
  class LocalStargatesImporter
    def import
      Eve::Stargate.pluck(:id).each do |stargate_id|
        Eve::UpdateStargateJob.perform_later(stargate_id)
      end
    end
  end
end
