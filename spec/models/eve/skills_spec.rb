# frozen_string_literal: true

require "rails_helper"

describe Eve::Skills do
  it { expect(described_class::SCIENCE_ID).to eq(3402) }

  it { expect(described_class::ADVANCED_INDUSTRY_ID).to eq(3388) }

  describe ".science" do
    let!(:type) { create(:eve_type, id: described_class::SCIENCE_ID, published: true) }

    specify { expect(described_class.science).to eq(type) }
  end

  describe ".advanced_industry" do
    let!(:type) { create(:eve_type, id: described_class::ADVANCED_INDUSTRY_ID, published: true) }

    specify { expect(described_class.advanced_industry).to eq(type) }
  end
end
