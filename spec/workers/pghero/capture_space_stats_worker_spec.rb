# frozen_string_literal: true

require "rails_helper"

describe Pghero::CaptureSpaceStatsWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    before { expect(PgHero).to receive(:capture_space_stats) }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
