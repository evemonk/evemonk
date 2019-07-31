# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalGraphicsImporter do
  describe "#import" do
    let(:graphic_id) { double }

    before do
      #
      # Eve::Graphic.pluck(:graphic_id) => [graphic_id]
      #
      expect(Eve::Graphic).to receive(:pluck).with(:graphic_id).and_return([graphic_id])
    end

    before { expect(Eve::GraphicImporterWorker).to receive(:perform_async).with(graphic_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
