# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe CorporationDecorator do
    describe '#as_json' do
      let(:date_founded) { Time.zone.now }

      let!(:corporation) do
        build_stubbed(:eve_corporation,
                      corporation_id: 98_134_807,
                      name: 'MyLittleDragon',
                      ticker: 'MYLID',
                      member_count: 120,
                      ceo_id: 1_208_274_826,
                      tax_rate: 0.09,
                      creator_id: 265_506_411,
                      alliance_id: 99_005_443,
                      description: 'description',
                      date_founded: date_founded,
                      corporation_url: 'http://',
                      home_station_id: 60_004_474,
                      shares: 1000)
      end

      subject { corporation.decorate.as_json }

      its([:corporation_id]) { should eq(98_134_807) }

      its([:name]) { should eq('MyLittleDragon') }

      its([:ticker]) { should eq('MYLID') }

      its([:member_count]) { should eq(120) }

      its([:ceo_id]) { should eq(1_208_274_826) }

      its([:tax_rate]) { should eq('0.09') }

      its([:creator_id]) { should eq(265_506_411) }

      its([:alliance_id]) { should eq(99_005_443) }

      its([:description]) { should eq('description') }

      its([:date_founded]) { should eq(date_founded.iso8601) }

      its([:corporation_url]) { should eq('http://') }

      its([:home_station_id]) { should eq(60_004_474) }

      its([:shares]) { should eq(1000) }
    end
  end
end
