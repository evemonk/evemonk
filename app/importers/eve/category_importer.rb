# frozen_string_literal: true

# TODO: update
module Eve
  class CategoryImporter < BaseImporter
    attr_reader :category_id, :locale

    def initialize(category_id, locale = :en)
      @category_id = category_id
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          eve_category = Eve::Category.find_or_initialize_by(category_id: category_id)

          return if esi.not_modified?

          eve_category.update!(esi.as_json)

          update_etag
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Category ID #{category_id}")

          etag.destroy!

          eve_category.destroy!
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseCategory.new(id: category_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
