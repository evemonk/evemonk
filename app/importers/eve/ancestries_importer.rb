# frozen_string_literal: true

module Eve
  class AncestriesImporter < BaseImporter
    attr_reader :language

    # @param language [String] Default: "en".
    def initialize(language = "en")
      @language = language
    end

    def import
      import! do
        Mobility.with_locale(language.to_sym) do
          ancestries.each do |ancestry|
            eve_ancestry = Eve::Ancestry.find_or_initialize_by(id: ancestry.id)

            eve_ancestry.update!(ancestry.as_json)
          end
        end
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(language: language, cache: true, cache_store: Rails.cache)
    end

    def ancestries
      @ancestries ||= client.universe.ancestries
    end
  end
end
