# frozen_string_literal: true

require "rails_helper"

RSpec.describe Pghero::CaptureSpaceStatsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("pghero") }

  describe "#perform" do
    context "when pghero enabled" do
      before { Flipper.enable(:pghero) }

      after { Flipper.disable(:pghero) }

      before { expect(PgHero).to receive(:capture_space_stats) }

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when pghero disabled" do
      before { expect(PgHero).not_to receive(:capture_space_stats) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
