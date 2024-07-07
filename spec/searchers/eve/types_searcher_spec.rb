# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::TypesSearcher do
  # describe "#initialize" do
  #   context "with parameters" do
  #     let(:query) { double }
  #
  #     let(:scope) { double }
  #
  #     subject { described_class.new(query, scope) }
  #
  #     its(:query) { should eq(query) }
  #
  #     its(:scope) { should eq(scope) }
  #   end
  #
  #   context "without parameters" do
  #     let(:scope) { double }
  #
  #     before { expect(Eve::Type).to receive(:all).and_return(scope) }
  #
  #     its(:query) { should eq(nil) }
  #
  #     its(:scope) { should eq(scope) }
  #   end
  # end
  #
  # describe "#search" do
  #   context "when query is empty" do
  #     let!(:type1) { create(:eve_type, name: "a", published: true) }
  #
  #     let!(:type2) { create(:eve_type, name: "b", published: true) }
  #
  #     let!(:type3) { create(:eve_type, name: "c", published: true) }
  #
  #     specify { expect(subject.search.count).to eq(3) }
  #
  #     specify { expect(subject.search.respond_to?(:all)).to eq(true) }
  #
  #     specify { expect(subject.search.to_a).to eq([type1, type2, type3]) }
  #   end
  #
  #   context "when query is present" do
  #     context "when name match" do
  #       let!(:type) do
  #         create(:eve_type,
  #           name: "Ragnarok",
  #           published: true)
  #       end
  #
  #       let(:query) { "Ragnarok" }
  #
  #       before { Eve::Type.reindex }
  #
  #       subject { described_class.new(query) }
  #
  #       specify { expect(subject.search.to_a).to eq([type]) }
  #     end
  #   end
  # end
end
