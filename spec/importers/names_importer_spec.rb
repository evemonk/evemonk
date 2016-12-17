require 'rails_helper'

describe NamesImporter do
  describe '#initialize' do
    let(:file) { double }

    let(:names) { double }

    subject { described_class.new(file) }

    before do
      #
      # EveOnline::SDE::Base.new(file) => names
      #
      expect(EveOnline::SDE::Base).to receive(:new).with(file).and_return(names)
    end

    specify { expect(subject.names).to eq(names) }
  end

  describe '#execute' do
    let(:file) { double }

    let(:name) { double }

    subject { described_class.new(file) }

    before do
      #
      # subject.names.data => [name]
      #
      expect(subject).to receive(:names) do
        double.tap do |a|
          expect(a).to receive(:data).and_return([name])
        end
      end
    end

    before do
      #
      # Eve::Name.create!(name)
      #
      expect(Eve::Name).to receive(:create!).with(name)
    end

    specify { expect { subject.execute }.not_to raise_error }
  end
end
