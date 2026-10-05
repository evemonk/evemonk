# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchBlueprintsQuery do
  let(:q) { double }

  subject { described_class.new(q) }

  it { expect(subject).to be_a(BaseQuery) }

  describe "#initialize" do
    context "without q and scope" do
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

      let!(:eve_type) { create(:eve_type, name_en: "Drake", published: true, is_blueprint: true) }

      let!(:index) { ActiveSearch.index(:eve_types) }

      before { index.add(eve_type) }

      subject { described_class.new(q) }

      specify { expect(subject.query.to_a).to eq([eve_type]) }
    end

    context "when q is not present" do
      let(:q) { "" }

      let(:scope) { Eve::Blueprint }

      before { expect(scope).to receive(:none).and_call_original }

      subject { described_class.new(q, scope) }

      specify { expect(subject.query).to eq([]) }
    end
  end
end
