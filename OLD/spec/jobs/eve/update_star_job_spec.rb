# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateStarJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:star_id) { double }

    before do
      #
      # Eve::StarImporter.new(star_id).import
      #
      expect(Eve::StarImporter).to receive(:new).with(star_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(star_id) }.not_to raise_error }
  end
end
