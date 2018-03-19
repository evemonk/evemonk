# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe FactionDecorator do
    describe '#as_json' do
      let!(:faction) do
        build_stubbed(:eve_faction,
                      faction_id: 500_002,
                      name: 'Minmatar Republic',
                      description: 'The Minmatar Republic was formed over a century ago when the Minmatar threw...',
                      solar_system_id: 30_002_544,
                      corporation_id: 1_000_051,
                      militia_corporation_id: 1_000_182,
                      size_factor: 5.0,
                      station_count: 570,
                      station_system_count: 291,
                      is_unique: true)
      end

      subject { faction.decorate.as_json }

      its([:faction_id]) { should eq(500_002) }

      its([:name]) { should eq('Minmatar Republic') }

      its([:description]) { should eq('The Minmatar Republic was formed over a century ago when the Minmatar threw...') }

      its([:solar_system_id]) { should eq(30_002_544) }

      its([:corporation_id]) { should eq(1_000_051) }

      its([:militia_corporation_id]) { should eq(1_000_182) }

      its([:size_factor]) { should eq(5.0) }

      its([:station_count]) { should eq(570) }

      its([:station_system_count]) { should eq(291) }

      its([:is_unique]) { should eq(true) }
    end
  end
end
