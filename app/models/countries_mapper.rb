# frozen_string_literal: true

class CountriesMapper
  class << self
    def countries
      data = []

      ISO3166::Data.codes.each do |code|
        data << {
          name: ISO3166::Country.new(code).iso_short_name,
          code: "+#{ISO3166::Country.new(code).country_code}"
        }
      end

      data.sort_by { |k, _| k[:name] }
    end
  end
end
