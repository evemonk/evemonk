# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationsSearcher do
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

      before { expect(Eve::Corporation).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:query) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end
  end

  describe "#search" do
    context "when query is empty" do
      let!(:corporation1) { create(:eve_corporation, name: "a") }

      let!(:corporation2) { create(:eve_corporation, name: "b") }

      let!(:corporation3) { create(:eve_corporation, name: "c") }

      subject { described_class.new }

      specify { expect(subject.search.count).to eq(3) }

      specify { expect(subject.search.respond_to?(:all)).to eq(true) }

      specify { expect(subject.search.to_a).to eq([corporation1, corporation2, corporation3]) }
    end

    context "when query is present" do
      context "when name match" do
        let!(:corporation) do
          create(:eve_corporation,
                 name: "MyLittleDragon",
                 ticker: nil)
        end

        let(:query) { "MyLittleDragon" }

        before { Eve::Corporation.reindex }

        subject { described_class.new(query) }

        specify { expect(subject.search.to_a).to eq([corporation]) }
      end

      context "when ticker match" do
        let!(:corporation) { create(:eve_corporation, name: nil, ticker: "MYLID") }

        let(:query) { "MYLID" }

        before { Eve::Corporation.reindex }

        subject { described_class.new(query) }

        specify { expect(subject.search.to_a).to eq([corporation]) }
      end
    end
  end
end
