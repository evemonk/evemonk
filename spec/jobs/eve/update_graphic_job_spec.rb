# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateGraphicJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:graphic_id) { double }

    before do
      #
      # Eve::GraphicImporter.new(graphic_id).import
      #
      expect(Eve::GraphicImporter).to receive(:new).with(graphic_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(graphic_id) }.not_to raise_error }
  end
end
