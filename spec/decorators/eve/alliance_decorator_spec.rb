# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe AllianceDecorator do
    describe '#as_json' do
      let(:date_founded) { Time.zone.now }

      let(:alliance) do
        build_stubbed(:eve_alliance,
                      name: 'Kids With Guns Alliance',
                      ticker: '-KWG-',
                      creator_id: 94_195_096,
                      creator_corporation_id: 98_306_624,
                      executor_corporation_id: 98_306_624,
                      date_founded: date_founded,
                      faction_id: 1)
      end

      subject { alliance.decorate.as_json }

      its([:name]) { should eq('Kids With Guns Alliance') }

      its([:ticker]) { should eq('-KWG-') }

      its([:creator_id]) { should eq(94_195_096) }

      its([:creator_corporation_id]) { should eq(98_306_624) }

      its([:executor_corporation_id]) { should eq(98_306_624) }

      its([:date_founded]) { should eq(date_founded.iso8601) }

      its([:faction_id]) { should eq(1) }
    end
  end
end
