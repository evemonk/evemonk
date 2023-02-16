# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalCategoriesImporter do
  describe "#import" do
    let(:id) { double }

    before do
      #
      # Eve::Category.ids => [id]
      #
      expect(Eve::Category).to receive(:ids).and_return([id])
    end

    before { expect(Eve::UpdateCategoryJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
