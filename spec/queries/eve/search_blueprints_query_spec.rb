# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchBlueprintsQuery do
  let(:search) { double }

  subject { described_class.new(search) }

  it { expect(subject).to be_a(BaseQuery) }

  describe "#initialize" do
    context "without search and scope" do
      let(:scope) { double }

      before do
        #
        # Eve::Blueprint.published.blueprints
        #
        expect(Eve::Blueprint).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:blueprints).and_return(scope)
          end
        end
      end

      subject { described_class.new }

      its(:search) { is_expected.to eq(nil) }

      its(:scope) { is_expected.to eq(scope) }
    end

    context "with search and scope" do
      let(:scope) { double }

      subject { described_class.new(search, scope) }

      its(:search) { is_expected.to eq(search) }

      its(:scope) { is_expected.to eq(scope) }
    end
  end

  describe "#query" do
    context "when search is present" do
      let(:search) { "Drake" }

      let(:scope) { class_double(Eve::Blueprint) }

      let(:query) { double }

      before { expect(scope).to receive(:search_by_name).with(search).and_return(query) }

      subject { described_class.new(search, scope) }

      specify { expect(subject.query).to eq(query) }
    end

    context "when search is not present" do
      let(:search) { "" }

      let(:scope) { Eve::Blueprint }

      before { expect(scope).to receive(:none).and_call_original }

      subject { described_class.new(search, scope) }

      specify { expect(subject.query).to eq([]) }
    end
  end
end
