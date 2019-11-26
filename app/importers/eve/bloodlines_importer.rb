# frozen_string_literal: true

module Eve
  class BloodlinesImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          esi = EveOnline::ESI::UniverseBloodlines.new(language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          esi.bloodlines.each do |bloodline|
            eve_bloodline = Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)

            eve_bloodline.update!(bloodline.as_json)
          end

          etag.update!(etag: esi.etag)
        end
      end
    end
  end
end
