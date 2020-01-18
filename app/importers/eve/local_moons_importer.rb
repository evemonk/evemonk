# frozen_string_literal: true

module Eve
  class LocalMoonsImporter
    def import
      Eve::Moon.pluck(:moon_id).each do |moon_id|
        Eve::UpdateMoonJob.perform_later(moon_id)
      end
    end
  end
end
