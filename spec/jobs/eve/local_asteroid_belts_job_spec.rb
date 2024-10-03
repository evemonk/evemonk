# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalAsteroidBeltsJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::LocalAsteroidBeltsImporter.new.import
      #
      expect(Eve::LocalAsteroidBeltsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
