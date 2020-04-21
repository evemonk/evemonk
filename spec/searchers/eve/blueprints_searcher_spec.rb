# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintsSearcher do
  describe "#search" do
    context "when query is empty" do
      let!(:blueprint1) do
        Eve::Blueprint.create!(attributes_for(:eve_type,
          type_id: 1,
          is_blueprint: true))
      end

      let!(:blueprint2) do
        Eve::Blueprint.create!(attributes_for(:eve_type,
          type_id: 2,
          is_blueprint: true))
      end

      let!(:blueprint3) do
        Eve::Blueprint.create!(attributes_for(:eve_type,
          type_id: 3,
          is_blueprint: true))
      end

      subject { described_class.new("") }

      specify { expect(subject.search.order(:type_id)).to eq([blueprint1, blueprint2, blueprint3]) }
    end

    context "when query is present" do
    end
  end
end
