# frozen_string_literal: true

module Eve
  class LocalTypesImporter
    def import
      Eve::Type.ids.each do |type_id|
        Eve::UpdateTypeJob.perform_later(type_id)
      end
    end
  end
end
