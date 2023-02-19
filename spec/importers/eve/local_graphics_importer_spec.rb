# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalGraphicsImporter do
  describe "#import" do
    let(:id) { double }

    before do
      #
      # Eve::Graphic.ids => [id]
      #
      expect(Eve::Graphic).to receive(:ids).and_return([id])
    end

    before { expect(Eve::UpdateGraphicJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
