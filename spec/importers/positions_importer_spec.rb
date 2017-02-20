require 'rails_helper'

describe PositionsImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:inv_positions) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::InvPositions.new(file) => inv_positions
      #
      expect(EveOnline::SDE::InvPositions).to receive(:new).with(file).and_return(inv_positions)
    end

    specify { expect(subject.inv_positions).to eq(inv_positions) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:inv_position) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.inv_positions.inv_positions => [inv_position]
      #
      expect(subject).to receive(:inv_positions) do
        double.tap do |a|
          expect(a).to receive(:inv_positions).and_return([inv_position])
        end
      end
    end

    before { expect(inv_position).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Position.create!(json)
      #
      expect(Eve::Position).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
