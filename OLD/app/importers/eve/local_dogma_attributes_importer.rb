# frozen_string_literal: true

module Eve
  class LocalDogmaAttributesImporter
    def import
      Eve::DogmaAttribute.pluck(:attribute_id).each do |attribute_id|
        Eve::UpdateDogmaAttributeJob.perform_later(attribute_id)
      end
    end
  end
end
