# frozen_string_literal: true

module Eve
  class GroupImporter
    attr_reader :group_id, :locale

    def initialize(group_id, locale = :en)
      @type_id = group_id
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          eve_group = Eve::Group.find_or_initialize_by(group_id: group_id)

          esi = EveOnline::ESI::UniverseGroup.new(id: group_id, language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          eve_group.update!(esi.as_json)

          etag.update!(etag: esi.etag, body: esi.response)
        rescue EveOnline::Exceptions::ResourceNotFound
          eve_group.destroy!
        end
      end
    end
  end
end
