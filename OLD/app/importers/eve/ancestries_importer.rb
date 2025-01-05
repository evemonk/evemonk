# frozen_string_literal: true

module Eve
  class AncestriesImporter < BaseImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          esi.ancestries.each do |ancestry|
            eve_ancestry = Eve::Ancestry.find_or_initialize_by(id: ancestry.id)

            eve_ancestry.update!(ancestry.as_json)
          end
        end
      end
    end

    private

    def esi
      @esi ||= EveOnline::ESI::UniverseAncestries.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
