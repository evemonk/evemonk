# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateMoonJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:planet_id) { double }

    let(:moon_id) { double }

    before do
      #
      # Eve::MoonImporter.new(planet_id, moon_id).import
      #
      expect(Eve::MoonImporter).to receive(:new).with(planet_id, moon_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(planet_id, moon_id) }.not_to raise_error }
  end
end
