# frozen_string_literal: true

module Eve
  class DogmaAttributeImporter < BaseImporter
    attr_reader :attribute_id

    def initialize(attribute_id)
      @attribute_id = attribute_id
    end

    def import
      import! do
        eve_dogma_attribute = Eve::DogmaAttribute.find_or_initialize_by(attribute_id: attribute_id)

        return if esi.not_modified?

        eve_dogma_attribute.update!(esi.as_json)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve DogmaAttribute ID #{attribute_id}")

        etag.destroy!

        eve_dogma_attribute.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::DogmaAttribute.new(id: attribute_id)
    end
  end
end
