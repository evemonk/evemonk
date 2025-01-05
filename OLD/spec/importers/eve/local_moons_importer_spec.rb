# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalMoonsImporter do
  describe "#import" do
    let(:planet_id) { double }

    let(:moon_id) { double }

    before do
      #
      # Eve::Moon.pluck(:planet_id, :moon_id) => [[planet_id, moon_id]]
      #
      expect(Eve::Moon).to receive(:pluck).with(:planet_id, :moon_id).and_return([[planet_id, moon_id]])
    end

    before { expect(Eve::UpdateMoonJob).to receive(:perform_later).with(planet_id, moon_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
