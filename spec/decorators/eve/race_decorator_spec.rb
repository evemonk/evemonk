# frozen_string_literal: true
require 'rails_helper'

describe Eve::RaceDecorator do
  describe '#as_json' do
    let!(:race) do
      create(:eve_race,
             description: 'Once a thriving tribal civilization, the Minmatar...',
             short_description: 'Breaking free of Amarrian subjugation, ...',
             race_id: 2,
             race_name: 'Minmatar',
             icon_id: 1440)
    end

    subject { race.decorate.as_json }

    its([:description]) { should eq('Once a thriving tribal civilization, the Minmatar...') }

    its([:short_description]) { should eq('Breaking free of Amarrian subjugation, ...') }

    its([:race_id]) { should eq(2) }

    its([:race_name]) { should eq('Minmatar') }

    its([:icon_id]) { should eq(1440) }
  end
end
