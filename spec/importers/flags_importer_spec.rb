require 'rails_helper'

describe FlagsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:flags) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Flags.new(file) => flags
      #
      expect(EveOnline::SDE::Flags).to receive(:new).with(file).and_return(flags)
    end

    specify { expect(subject.flags).to eq(flags) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:flag) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.flags.flags => [flag]
      #
      expect(subject).to receive(:flags) do
        double.tap do |a|
          expect(a).to receive(:flags).and_return([flag])
        end
      end
    end

    before { expect(flag).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Flag.create!(json)
      #
      expect(Eve::Flag).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
