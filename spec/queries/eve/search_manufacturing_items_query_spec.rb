# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchManufacturingItemsQuery do
  let(:q) { double }

  subject { described_class.new(q) }

  it { expect(subject).to be_a(BaseQuery) }

  describe "#initialize" do
    context "without q and scope" do
      let(:scope) { double }

      before do
        #
        # Eve::Type.published.manufacturing_items
        #
        expect(Eve::Type).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:manufacturing_items).and_return(scope)
          end
        end
      end

      subject { described_class.new }

      its(:q) { is_expected.to eq(nil) }

      its(:scope) { is_expected.to eq(scope) }
    end

    context "with q and scope" do
      let(:scope) { double }

      subject { described_class.new(q, scope) }

      its(:q) { is_expected.to eq(q) }

      its(:scope) { is_expected.to eq(scope) }
    end
  end

  describe "#query" do
    context "when q is present" do
      let(:q) { "Drake" }

      let(:scope) { class_double(Eve::Type) }

      let(:query) { double }

      before { expect(scope).to receive(:search).with(q).and_return(query) }

      subject { described_class.new(q, scope) }

      specify { expect(subject.query).to eq(query) }
    end

    context "when q is not present" do
      let(:q) { "" }

      let(:scope) { Eve::Type }

      before { expect(scope).to receive(:none).and_call_original }

      subject { described_class.new(q, scope) }

      specify { expect(subject.query).to eq([]) }
    end
  end
end
