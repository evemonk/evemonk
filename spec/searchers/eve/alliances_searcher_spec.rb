# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesSearcher do
  describe "#initialize" do
    context "with parameters" do
      let(:query) { double }

      let(:scope) { double }

      subject { described_class.new(query, scope) }

      its(:query) { should eq(query) }

      its(:scope) { should eq(scope) }
    end

    context "without parameters" do
      let(:scope) { double }

      before { expect(Eve::Alliance).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:query) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end
  end

  describe "#search" do
    context "when query is empty" do
      let!(:alliance1) { create(:eve_alliance, name: "a") }

      let!(:alliance2) { create(:eve_alliance, name: "b") }

      let!(:alliance3) { create(:eve_alliance, name: "c") }

      subject { described_class.new }

      specify { expect(subject.search.count).to eq(3) }

      specify { expect(subject.search.respond_to?(:all)).to eq(true) }

      specify { expect(subject.search.to_a).to eq([alliance1, alliance2, alliance3]) }
    end

    context "when query is present" do
      context "when name match" do
        let!(:alliance) do
          create(:eve_alliance,
                 name: "Northern Coalition.",
                 ticker: nil)
        end

        let(:query) { "Northern Coalition." }

        before { Eve::Alliance.reindex }

        subject { described_class.new(query) }

        specify { expect(subject.search.to_a).to eq([alliance]) }
      end

      context "when ticker match" do
        let!(:alliance) do
          create(:eve_alliance,
                 name: nil,
                 ticker: "NC")
        end

        let(:query) { "NC" }

        before { Eve::Alliance.reindex }

        subject { described_class.new(query) }

        specify { expect(subject.search.to_a).to eq([alliance]) }
      end
    end
  end
end
