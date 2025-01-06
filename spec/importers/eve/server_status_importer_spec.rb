# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ServerStatusImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    before { VCR.insert_cassette "esi/server/status" }

    after { VCR.eject_cassette }

    specify { expect { subject.import }.to change(Eve::ServerStatus, :count).by(1) }

    specify do
      subject.import

      server_status = Eve::ServerStatus.first

      expect(server_status.players).to eq(29_568)

      expect(server_status.server_version).to eq("2776971")

      expect(server_status.start_time).to eq("2025-01-02T11:01:17Z")

      expect(server_status.vip).to eq(nil)
    end
  end
end
