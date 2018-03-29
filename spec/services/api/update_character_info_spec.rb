# frozen_string_literal: true

require 'rails_helper'

describe Api::UpdateCharacterInfo do
  describe '#initialize' do
    let(:character) { double }

    subject { described_class.new(character) }

    its(:character) { should eq(character) }
  end

  describe '#update!' do
    let(:character) { double }

    subject { described_class.new(character) }

    before { expect(subject).to receive(:character_info) }

    before { expect(subject).to receive(:character_wallet) }

    before { expect(subject).to receive(:character_portrait) }

    before { expect(subject).to receive(:character_attributes) }

    before { expect(subject).to receive(:character_corporation_info) }

    before { expect(subject).to receive(:character_loyalty_points) }

    specify { expect { subject.update! }.not_to raise_error }
  end

  # private methods

  describe '#character_info' do
    before { VCR.insert_cassette 'api/update_character_info/character_info/success' }

    after { VCR.eject_cassette }

    let!(:race) { create(:eve_race, race_id: 2) }

    let(:token) { 'XPyr6SPgegR0FhP2k5yUtG8LQeU9XagHtqWo01EN9z2Djy6pcnED173V7jp-ifLgYAPdu58p1cF0Ye4jUwWJ1Q2' }

    let!(:character) do
      create(:character,
             uid: 1_337_512_245,
             token: token,
             name: 'Cat',
             gender: 'female')
    end

    subject { described_class.new(character) }

    specify { expect { subject.send(:character_info) }.to change { character.name }.from('Cat').to('Johnn Dillinger') }

    specify { expect { subject.send(:character_info) }.to change { character.gender }.from('female').to('male') }

    # TODO:
    # {:corporation_id=>98134807,
    #  :birthday=>Fri, 15 Jan 2010 15:26:00 UTC +00:00,
    #  :race_id=>2,
    #  :bloodline_id=>4,
    #  :description=>"",
    #  :alliance_id=>99005443,
    #  :ancestry_id=>24,
    #  :security_status=>1.8694881661345457}
  end

  describe '#character_portrait' do
    before { VCR.insert_cassette 'api/update_character_info/character_portrait/success' }

    after { VCR.eject_cassette }

    let(:token) { 'XPyr6SPgegR0FhP2k5yUtG8LQeU9XagHtqWo01EN9z2Djy6pcnED173V7jp-ifLgYAPdu58p1cF0Ye4jUwWJ1Q2' }

    let!(:character) do
      create(:character,
             uid: 1_337_512_245,
             token: token,
             portrait_small: nil,
             portrait_medium: nil,
             portrait_large: nil,
             portrait_huge: nil)
    end

    subject { described_class.new(character) }

    specify { expect { subject.send(:character_portrait) }.to change { character.portrait_small }.from(nil).to('http://image.eveonline.com/Character/1337512245_64.jpg') }

    specify { expect { subject.send(:character_portrait) }.to change { character.portrait_medium }.from(nil).to('http://image.eveonline.com/Character/1337512245_128.jpg') }

    specify { expect { subject.send(:character_portrait) }.to change { character.portrait_large }.from(nil).to('http://image.eveonline.com/Character/1337512245_256.jpg') }

    specify { expect { subject.send(:character_portrait) }.to change { character.portrait_huge }.from(nil).to('http://image.eveonline.com/Character/1337512245_512.jpg') }
  end
end
