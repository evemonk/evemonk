require 'rails_helper'

describe CharacterDecorator do
  describe '#as_json' do
    let!(:character) do
      create(:character,
             id: 123,
             uid: 1_337_512_245,
             name: 'Johnn Dillinger')
    end

    subject { character.decorate.as_json }

    its([:id]) { should eq(123) }

    its([:uid]) { should eq(1_337_512_245) }

    its([:name]) { should eq('Johnn Dillinger') }

    specify { expect(subject[:race].class).to eq(Eve::RaceDecorator) }

    its([:created_at]) { should eq(character.created_at.iso8601) }

    its([:updated_at]) { should eq(character.updated_at.iso8601) }
  end
end
