# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ServerStatusImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    before { VCR.insert_cassette "esi/server_status/info" }

    after { VCR.eject_cassette }

    specify { expect { subject.import }.to change(Eve::ServerStatus, :count).by(1) }

    specify do
      subject.import

      server_status = Eve::ServerStatus.first

      expect(server_status.players).to eq(34_408)

      expect(server_status.server_version).to eq("3145366")

      expect(server_status.start_time).to eq(Time.utc(2026, 1, 1, 11, 1, 47))

      expect(server_status.vip).to eq(nil)
    end
  end
end
