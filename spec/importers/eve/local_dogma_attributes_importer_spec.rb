# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalDogmaAttributesImporter do
  describe "#import" do
    let(:attribute_id) { double }

    before do
      #
      # Eve::DogmaAttribute.pluck(:attribute_id) # => [attribute_id]
      #
      expect(Eve::DogmaAttribute).to receive(:pluck).with(:attribute_id).and_return([attribute_id])
    end

    before { expect(Eve::UpdateDogmaAttributeJob).to receive(:perform_later).with(attribute_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
