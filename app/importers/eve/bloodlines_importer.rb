# frozen_string_literal: true

module Eve
  class BloodlinesImporter < BaseImporter
    attr_reader :language

    # @param language [String] Default: "en".
    def initialize(language = "en")
      @language = language
    end

    def import
      import! do
        Mobility.with_locale(language.to_sym) do
          bloodlines.each do |bloodline|
            eve_bloodline = Eve::Bloodline.find_or_initialize_by(id: bloodline.id)

            eve_bloodline.update!(bloodline.as_json)
          end
        end
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(language: language, cache: true, cache_store: Rails.cache)
    end

    def bloodlines
      @bloodlines ||= client.universe.bloodlines
    end
  end
end
