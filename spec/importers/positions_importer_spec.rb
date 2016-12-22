require 'rails_helper'

describe PositionsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:positions) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Positions.new(file) => positions
      #
      expect(EveOnline::SDE::Positions).to receive(:new).with(file).and_return(positions)
    end

    specify { expect(subject.positions).to eq(positions) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:position) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.positions.positions => [position]
      #
      expect(subject).to receive(:positions) do
        double.tap do |a|
          expect(a).to receive(:positions).and_return([position])
        end
      end
    end

    before { expect(position).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Position.create!(json)
      #
      expect(Eve::Position).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
