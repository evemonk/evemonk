# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateGraphicsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::GraphicsImporter.new.import
      #
      expect(Eve::GraphicsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
