require 'rails_helper'

describe FlagsImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:flags) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Base.new(file) => flags
      #
      expect(EveOnline::SDE::Base).to receive(:new).with(file).and_return(flags)
    end

    specify { expect(subject.flags).to eq(flags) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:flag) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.flags.data => [flag]
      #
      expect(subject).to receive(:flags) do
        double.tap do |a|
          expect(a).to receive(:data).and_return([flag])
        end
      end
    end

    before do
      #
      # Eve::Flag.create!(flag)
      #
      expect(Eve::Flag).to receive(:create!).with(flag)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
