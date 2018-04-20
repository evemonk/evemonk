# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe RaceDecorator do
    describe '#as_json' do
      let(:race) do
        build_stubbed(:eve_race,
                      description: 'Once a thriving tribal civilization, the Minmatar...',
                      race_id: 2,
                      name: 'Minmatar',
                      alliance_id: 500_002)
      end

      subject { race.decorate.as_json }

      its([:description]) { should eq('Once a thriving tribal civilization, the Minmatar...') }

      its([:race_id]) { should eq(2) }

      its([:name]) { should eq('Minmatar') }

      its([:alliance_id]) { should eq(500_002) }
    end
  end
end
