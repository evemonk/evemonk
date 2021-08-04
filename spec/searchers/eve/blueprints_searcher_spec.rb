# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintsSearcher do
  # describe "#initialize" do
  #   let(:query) { double }
  #
  #   let(:scope) { double }
  #
  #   context "with parameters" do
  #     subject { described_class.new(query, scope) }
  #
  #     its(:query) { should eq(query) }
  #
  #     its(:scope) { should eq(scope) }
  #   end
  #
  #   context "without parameters" do
  #     before { expect(Eve::Blueprint).to receive(:all).and_return(scope) }
  #
  #     subject { described_class.new(query) }
  #
  #     its(:query) { should eq(query) }
  #
  #     its(:scope) { should eq(scope) }
  #   end
  # end
  #
  # describe "#search" do
  #   context "when query is empty" do
  #     let!(:blueprint1) do
  #       Eve::Blueprint.create!(attributes_for(:eve_type,
  #         type_id: 1,
  #         is_blueprint: true,
  #         published: true))
  #     end
  #
  #     let!(:blueprint2) do
  #       Eve::Blueprint.create!(attributes_for(:eve_type,
  #         type_id: 2,
  #         is_blueprint: true,
  #         published: true))
  #     end
  #
  #     let!(:blueprint3) do
  #       Eve::Blueprint.create!(attributes_for(:eve_type,
  #         type_id: 3,
  #         is_blueprint: true,
  #         published: true))
  #     end
  #
  #     before { Eve::Type.reindex }
  #
  #     subject { described_class.new("") }
  #
  #     specify { expect(subject.search.order(:type_id)).to eq([blueprint1, blueprint2, blueprint3]) }
  #   end
  #
  #   context "when query is present" do
  #     context "when search return empty list" do
  #       before { Eve::Type.reindex }
  #
  #       subject { described_class.new("drake") }
  #
  #       specify { expect(subject.search).to eq(Eve::Blueprint.none) }
  #     end
  #
  #     context "when search find blueprints" do
  #       let!(:blueprint1) do
  #         create(:eve_type,
  #           type_id: 1,
  #           name_en: "Drake Blueprint",
  #           is_blueprint: true,
  #           published: true)
  #       end
  #
  #       before { Eve::Type.reindex }
  #
  #       subject { described_class.new("drake") }
  #
  #       specify { expect(subject.search.to_a).to eq([Eve::Blueprint.first]) }
  #     end
  #   end
  # end
end
