# frozen_string_literal: true

module Eve
  class RacesImporter < BaseImporter
    attr_reader :language

    # @param language [String] Default: "en".
    def initialize(language = "en")
      @language = language
    end

    def import
      import! do
        Mobility.with_locale(language.to_sym) do
          races.each do |race|
            eve_race = Eve::Race.find_or_initialize_by(id: race.id)

            eve_race.update!(race.as_json)
          end
        end
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(language: language, cache: true, cache_store: Rails.cache)
    end

    def races
      @races ||= client.universe.races
    end
  end
end
