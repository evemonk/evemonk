# frozen_string_literal: true

require "rails_helper"

describe Eve::ManufacturingItemsSearcher do
  describe "#initialize" do
    let(:query) { double }

    let(:scope) { double }

    context "with parameters" do
      subject { described_class.new(query, scope) }

      its(:query) { should eq(query) }

      its(:scope) { should eq(scope) }
    end

    context "without parameters" do
      before { expect(Eve::Type).to receive(:all).and_return(scope) }

      subject { described_class.new(query) }

      its(:query) { should eq(query) }

      its(:scope) { should eq(scope) }
    end
  end

  describe "#search" do
    context "when query is empty" do
      let!(:type1) do
        create(:eve_type,
          type_id: 1,
          is_manufacturing_item: true,
          published: true)
      end

      let!(:type2) do
        create(:eve_type,
          type_id: 2,
          is_manufacturing_item: true,
          published: true)
      end

      let!(:type3) do
        create(:eve_type,
          type_id: 3,
          is_manufacturing_item: true,
          published: true)
      end

      before { Eve::Type.reindex }

      subject { described_class.new("") }

      specify { expect(subject.search.order(:type_id)).to eq([type1, type2, type3]) }
    end

    context "when query is present" do
      context "when search return empty list" do
        before { Eve::Type.reindex }

        subject { described_class.new("drake") }

        specify { expect(subject.search).to eq(Eve::Type.none) }
      end

      context "when search find items" do
        let!(:type1) do
          create(:eve_type,
            type_id: 1,
            name_en: "Drake",
            is_manufacturing_item: true,
            published: true)
        end

        before { Eve::Type.reindex }

        subject { described_class.new("drake") }

        specify { expect(subject.search.to_a).to eq([Eve::Type.first]) }
      end
    end
  end
end
