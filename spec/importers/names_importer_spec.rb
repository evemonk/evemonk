require 'rails_helper'

describe NamesImporter do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    let(:file) { double }

    let(:inv_names) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::InvNames.new(file) => inv_names
      #
      expect(EveOnline::SDE::InvNames).to receive(:new).with(file).and_return(inv_names)
    end

    specify { expect(subject.inv_names).to eq(inv_names) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:inv_name) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.inv_names.inv_names => [inv_name]
      #
      expect(subject).to receive(:inv_names) do
        double.tap do |a|
          expect(a).to receive(:inv_names).and_return([inv_name])
        end
      end
    end

    before { expect(inv_name).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Name.create!(json)
      #
      expect(Eve::Name).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
