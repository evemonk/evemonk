# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalTypesImporter do
  describe "#import" do
    let(:id) { double }

    before do
      #
      # Eve::Type.ids => [id]
      #
      expect(Eve::Type).to receive(:ids).and_return([id])
    end

    before { expect(Eve::UpdateTypeJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
