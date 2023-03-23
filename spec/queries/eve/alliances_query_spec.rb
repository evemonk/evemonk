# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesQuery do
  let(:order_by) { double }

  subject { described_class.new(order_by) }

  it { should be_a(BaseQuery) }

  describe "#initialize" do
    context "without order_by and scope" do
      let(:scope) { double }

      before { expect(Eve::Alliance).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:order_by) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end

    context "with order_by and scope" do
      let(:scope) { double }

      subject { described_class.new(order_by, scope) }

      its(:order_by) { should eq(order_by) }

      its(:scope) { should eq(scope) }
    end
  end

  describe "#query" do
    context "when order_by is present" do
      context "when order_by is CORPORATIONS_COUNT_DESC" do
        let!(:eve_alliance_1) { create(:eve_alliance, id: 1, corporations_count: 100) }

        let!(:eve_alliance_2) { create(:eve_alliance, id: 2, corporations_count: 200) }

        let(:order_by) { "CORPORATIONS_COUNT_DESC" }

        subject { described_class.new(order_by) }

        specify { expect(subject.query).to eq([eve_alliance_2, eve_alliance_1]) }
      end

      context "when order_by is CORPORATIONS_COUNT_ASC" do
        let!(:eve_alliance_1) { create(:eve_alliance, id: 1, corporations_count: 100) }

        let!(:eve_alliance_2) { create(:eve_alliance, id: 2, corporations_count: 200) }

        let(:order_by) { "CORPORATIONS_COUNT_ASC" }

        subject { described_class.new(order_by) }

        specify { expect(subject.query).to eq([eve_alliance_1, eve_alliance_2]) }
      end

      # value "CHARACTERS_COUNT_DESC", "Order by characters_count desc"
      # value "CHARACTERS_COUNT_ASC", "Order by characters_count asc"

      context "when order_by is NONE" do
        let!(:eve_alliance_1) { create(:eve_alliance, id: 1) }

        let!(:eve_alliance_2) { create(:eve_alliance, id: 2) }

        let(:order_by) { "NONE" }

        subject { described_class.new(order_by) }

        specify { expect(subject.query).to eq([eve_alliance_1, eve_alliance_2]) }
      end
    end

    context "when order_by is not present" do
      let!(:eve_alliance_1) { create(:eve_alliance, id: 1) }

      let!(:eve_alliance_2) { create(:eve_alliance, id: 2) }

      let(:order_by) { nil }

      subject { described_class.new(order_by) }

      specify { expect(subject.query).to eq([eve_alliance_1, eve_alliance_2]) }
    end
  end
end
