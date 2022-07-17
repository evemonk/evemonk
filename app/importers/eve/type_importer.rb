# frozen_string_literal: true

module Eve
  class TypeImporter < BaseImporter
    attr_reader :type_id, :locale

    def initialize(type_id, locale = :en)
      @type_id = type_id
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          eve_type = Eve::Type.find_or_initialize_by(id: type_id)

          eve_type.update!(esi.as_json)

          import_type_dogma_attributes(eve_type)

          import_type_dogma_effects(eve_type)
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Type ID #{type_id}")

          eve_type.destroy!
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseType.new(type_id: type_id, language: LanguageMapper::LANGUAGES[locale])
    end

    private

    def import_type_dogma_attributes(eve_type)
      return unless locale == :en

      eve_type.type_dogma_attributes.destroy_all

      esi.dogma_attributes.each do |dogma_attribute|
        eve_type.type_dogma_attributes.create!(dogma_attribute.as_json)
      end
    end

    def import_type_dogma_effects(eve_type)
      return unless locale == :en

      eve_type.type_dogma_effects.destroy_all

      esi.dogma_effects.each do |dogma_effect|
        eve_type.type_dogma_effects.create!(dogma_effect.as_json)
      end
    end
  end
end
