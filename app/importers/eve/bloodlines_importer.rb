# frozen_string_literal: true

module Eve
  class BloodlinesImporter < BaseImporter
    attr_reader :locale

    # @param locale [String] Default: "en".
    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          esi.bloodlines.each do |bloodline|
            eve_bloodline = Eve::Bloodline.find_or_initialize_by(id: bloodline.id)

            eve_bloodline.update!(bloodline.as_json)
          end
        end
      end
    end

    private

    def esi
      @esi ||= EveOnline::ESI::UniverseBloodlines.new(language: LanguageMapper::LANGUAGES[locale], cache: Rails.cache)
    end

    def client
      @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
    end
  end
end
