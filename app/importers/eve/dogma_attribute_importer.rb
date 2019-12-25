# frozen_string_literal: true

module Eve
  class DogmaAttributeImporter
    attr_reader :attribute_id

    def initialize(attribute_id)
      @attribute_id = attribute_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_dogma_attribute = Eve::DogmaAttribute.find_or_initialize_by(attribute_id: attribute_id)

        esi = EveOnline::ESI::DogmaAttribute.new(id: attribute_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_dogma_attribute.update!(esi.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_dogma_attribute.destroy!
      end
    end
  end
end
