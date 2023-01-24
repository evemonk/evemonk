# frozen_string_literal: true

module Eve
  class BloodlinesImporter < BaseImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          esi.bloodlines.each do |bloodline|
            eve_bloodline = Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)

            eve_bloodline.update!(bloodline.as_json)
          end
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseBloodlines.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
