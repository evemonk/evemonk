# frozen_string_literal: true

# TODO: update
module Eve
  class LocalTypesImporter
    def import
      Eve::Type.pluck(:type_id).each do |type_id|
        Eve::UpdateTypeJob.perform_later(type_id)
      end
    end
  end
end
