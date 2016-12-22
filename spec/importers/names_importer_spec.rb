require 'rails_helper'

describe NamesImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:names) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Names.new(file) => names
      #
      expect(EveOnline::SDE::Names).to receive(:new).with(file).and_return(names)
    end

    specify { expect(subject.names).to eq(names) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:name) { double }

    let(:json) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.names.names => [name]
      #
      expect(subject).to receive(:names) do
        double.tap do |a|
          expect(a).to receive(:names).and_return([name])
        end
      end
    end

    before { expect(name).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Name.create!(json)
      #
      expect(Eve::Name).to receive(:create!).with(json)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
