# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchAlliancesQuery do
  let(:q) { double }

  subject { described_class.new(q) }

  it { expect(subject).to be_a(BaseQuery) }

  describe "#initialize" do
    context "without q and scope" do
      let(:scope) { double }

      before { expect(Eve::Alliance).to receive(:all).and_return(scope) }

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
      let(:q) { "The Dead Parrots" }

      let!(:eve_alliance) { create(:eve_alliance, name: "The Dead Parrots") }

      let!(:index) { ActiveSearch.index(:eve_alliances) }

      before { index.add(eve_alliance) }

      subject { described_class.new(q) }

      specify { expect(subject.query.to_a).to eq([eve_alliance]) }
    end

    context "when q is not present" do
      let(:q) { "" }

      let(:scope) { double }

      subject { described_class.new(q, scope) }

      specify { expect(subject.query).to eq(scope) }
    end
  end
end
