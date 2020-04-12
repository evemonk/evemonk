# frozen_string_literal: true

require "rails_helper"

describe Sde::BlueprintsJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:file) { double }

    before do
      #
      # Sde::BlueprintsImporter.new(file).import
      #
      expect(Sde::BlueprintsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(file) }.not_to raise_error }
  end
end
