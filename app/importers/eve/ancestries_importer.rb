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
            eve_ancestry = Eve::Ancestry.find_or_initialize_by(ancestry_id: ancestry.ancestry_id)

            eve_ancestry.update!(ancestry.as_json)
          end
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseAncestries.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
