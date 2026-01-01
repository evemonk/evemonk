# frozen_string_literal: true

module Eve
  class FactionsImporter < BaseImporter
    attr_reader :language

    # @param language [String] Default: "en".
    def initialize(language = "en")
      @language = language
    end

    def import
      import! do
        Mobility.with_locale(language.to_sym) do
          factions.each do |faction|
            eve_faction = Eve::Faction.find_or_initialize_by(id: faction.id)

            eve_faction.update!(faction.as_json)
          end
        end
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(language: language, cache: true, cache_store: Rails.cache)
    end

    def factions
      @factions ||= client.universe.factions
    end
  end
end
