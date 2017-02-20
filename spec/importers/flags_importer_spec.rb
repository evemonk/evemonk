require 'rails_helper'

describe FlagsImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:inv_flags) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::InvFlags.new(file) => inv_flags
      #
      expect(EveOnline::SDE::InvFlags).to receive(:new).with(file).and_return(inv_flags)
    end

    specify { expect(subject.inv_flags).to eq(inv_flags) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:inv_flag) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.inv_flags.inv_flags => [inv_flag]
      #
      expect(subject).to receive(:inv_flags) do
        double.tap do |a|
          expect(a).to receive(:inv_flags).and_return([inv_flag])
        end
      end
    end

    before { expect(inv_flag).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Flag.create!(json)
      #
      expect(Eve::Flag).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
