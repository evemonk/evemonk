# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalPlanetsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::LocalPlanetsImporter.new.import
      #
      expect(Eve::LocalPlanetsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
