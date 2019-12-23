# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalCategoriesImporter do
  describe "#import" do
    let(:category_id) { double }

    before do
      #
      # Eve::Category.pluck(:category_id) => [category_id]
      #
      expect(Eve::Category).to receive(:pluck).with(:category_id).and_return([category_id])
    end

    before { expect(Eve::UpdateCategoryJob).to receive(:perform_later).with(category_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
