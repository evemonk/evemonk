# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalAlliancesImporter do
  describe "#import" do
    let!(:eve_alliance) { create(:eve_alliance) }

    before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).with(eve_alliance.id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
