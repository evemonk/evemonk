# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalMoonsImporter do
  describe "#import" do
    let(:moon_id) { double }

    before do
      #
      # Eve::Moon.pluck(:moon_id) => [moon_id]
      #
      expect(Eve::Moon).to receive(:pluck).with(:moon_id).and_return([moon_id])
    end

    before { expect(Eve::UpdateMoonJob).to receive(:perform_later).with(moon_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
