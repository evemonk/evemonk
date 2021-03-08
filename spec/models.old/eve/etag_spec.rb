# frozen_string_literal: true

require "rails_helper"

describe Eve::Etag do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_etags") }

  it { should validate_presence_of(:url) }

  describe "uniqueness" do
    subject { create(:eve_etag) }

    it { should validate_uniqueness_of(:url) }
  end

  it { should validate_presence_of(:etag) }
end
