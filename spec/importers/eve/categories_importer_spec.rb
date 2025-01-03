# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CategoriesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    let!(:eve_category) { create(:eve_category, id: 9_999) }

    before { VCR.insert_cassette "esi/universe/categories" }

    after { VCR.eject_cassette }

    specify do
      subject.import

      expect(Eve::Category.find_by(id: 9_999)).to eq(nil)

      expect(Eve::UpdateCategoryJob).to have_been_enqueued.exactly(47).times
    end
  end
end
