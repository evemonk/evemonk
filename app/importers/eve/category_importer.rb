# frozen_string_literal: true

module Eve
  class CategoryImporter
    attr_reader :category_id, :locale

    def initialize(category_id, locale = :en)
      @category_id = category_id
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          eve_category = Eve::Category.find_or_initialize_by(category_id: category_id)

          esi = EveOnline::ESI::UniverseCategory.new(id: category_id, language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          eve_category.update!(esi.as_json)

          etag.update!(etag: esi.etag, body: esi.response)
        rescue EveOnline::Exceptions::ResourceNotFound
          eve_category.destroy!
        end
      end
    end
  end
end
