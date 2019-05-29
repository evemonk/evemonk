# frozen_string_literal: true

module Eve
  class LocalTypesImporter
    def import
      Eve::Type.pluck(:type_id).each do |type_id|
        Eve::TypeImporterWorker.perform_async(type_id)
      end
    end
  end
end
