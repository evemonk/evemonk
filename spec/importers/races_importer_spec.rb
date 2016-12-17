require 'rails_helper'

describe RacesImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:races) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Races.new(file) => races
      #
      expect(EveOnline::SDE::Races).to receive(:new).with(file).and_return(races)
    end

    specify { expect(subject.races).to eq(races) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:race) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.races.data => [race]
      #
      expect(subject).to receive(:races) do
        double.tap do |a|
          expect(a).to receive(:data).and_return([race])
        end
      end
    end

    before do
      #
      # Eve::Race.create!(race)
      #
      expect(Eve::Race).to receive(:create!).with(race)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
