# frozen_string_literal: true

require "rails_helper"

describe Eve::SearchManufacturingItemsQuery do
  let(:search) { double }

  subject { described_class.new(search) }

  it { should be_a(BaseQuery) }

  describe "#initialize" do
    context "without search and scope" do
      let(:scope) { double }

      before { expect(Eve::Type).to receive(:published_manufacturing_items).and_return(scope) }

      subject { described_class.new }

      its(:search) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end

    context "with search and scope" do
      let(:scope) { double }

      subject { described_class.new(search, scope) }

      its(:search) { should eq(search) }

      its(:scope) { should eq(scope) }
    end
  end

  describe "#query" do
    context "when search is present" do
      let(:search) { "Drake" }

      let(:scope) { class_double(Eve::Type) }

      let(:query) { double }

      before { expect(scope).to receive(:search_by_name).with(search).and_return(query) }

      subject { described_class.new(search, scope) }

      specify { expect(subject.query).to eq(query) }
    end

    context "when search is not present" do
      let(:search) { "" }

      let(:scope) { double }

      subject { described_class.new(search, scope) }

      specify { expect(subject.query).to eq(scope) }
    end
  end
end
