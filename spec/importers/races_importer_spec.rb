# frozen_string_literal: true

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

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.races.races => [race]
      #
      expect(subject).to receive(:races) do
        double.tap do |a|
          expect(a).to receive(:races).and_return([race])
        end
      end
    end

    before { expect(race).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Race.create!(json)
      #
      expect(Eve::Race).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
