require 'rails_helper'

describe RacesImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:chr_races) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::ChrRaces.new(file) => chr_races
      #
      expect(EveOnline::SDE::ChrRaces).to receive(:new).with(file).and_return(chr_races)
    end

    specify { expect(subject.chr_races).to eq(chr_races) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:chr_race) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.chr_races.chr_races => [chr_race]
      #
      expect(subject).to receive(:chr_races) do
        double.tap do |a|
          expect(a).to receive(:chr_races).and_return([chr_race])
        end
      end
    end

    before { expect(chr_race).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Race.create!(json)
      #
      expect(Eve::Race).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
