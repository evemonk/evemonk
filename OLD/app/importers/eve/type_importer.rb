# frozen_string_literal: true

module Eve
  class TypeImporter
    attr_reader :type_id

    def initialize(type_id)
      @type_id = type_id
    end

    # TODO: Import more info (dogma effects, attributes etc)
    def import
      eve_type = Eve::Type.find_or_initialize_by(type_id: type_id)

      eveonline_esi_type = EveOnline::ESI::UniverseType.new(id: type_id)

      etag = Etag.find_or_initialize_by(url: eveonline_esi_type.url)

      eveonline_esi_type.etag = etag.etag

      return if eveonline_esi_type.not_modified?

      eve_type.update!(eveonline_esi_type.as_json)

      etag.update!(etag: eveonline_esi_type.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_type.destroy!
    end
  end
end
