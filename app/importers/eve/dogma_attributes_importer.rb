# frozen_string_literal: true

module Eve
  class DogmaAttributesImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::DogmaAttributes.new
    end

    def import
      ActiveRecord::Base.transaction do
        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_dogma_attributes

        remove_old_dogma_attributes

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def etag
      @etag ||= Eve::Etag.find_or_initialize_by(url: esi.url)
    end

    def import_new_dogma_attributes
      eve_dogma_attribute_ids = Eve::DogmaAttribute.pluck(:attribute_id)

      eve_dogma_attribute_ids_to_create = esi.attribute_ids - eve_dogma_attribute_ids

      eve_dogma_attribute_ids_to_create.each do |attribute_id|
        Eve::UpdateDogmaAttributeJob.perform_later(attribute_id)
      end
    end

    def remove_old_dogma_attributes
      eve_dogma_attribute_ids = Eve::DogmaAttribute.pluck(:attribute_id)

      eve_dogma_attribute_ids_to_remove = eve_dogma_attribute_ids - esi.attribute_ids

      eve_dogma_attribute_ids_to_remove.each do |attribute_id|
        eve_dogma_attribute = Eve::DogmaAttribute.find_or_initialize_by(attribute_id: attribute_id)

        eve_dogma_attribute.destroy!
      end
    end
  end
end
