require 'rails_helper'

describe PositionsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:positions) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Base.new(file) => positions
      #
      expect(EveOnline::SDE::Base).to receive(:new).with(file).and_return(positions)
    end

    specify { expect(subject.positions).to eq(positions) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:position) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.positions.data => [position]
      #
      expect(subject).to receive(:positions) do
        double.tap do |a|
          expect(a).to receive(:data).and_return([position])
        end
      end
    end

    before do
      #
      # Eve::Position.create!(position)
      #
      expect(Eve::Position).to receive(:create!).with(position)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
