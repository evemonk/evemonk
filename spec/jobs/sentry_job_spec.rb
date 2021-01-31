# frozen_string_literal: true

require "rails_helper"

describe SentryJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("sentry") }

  describe "#perform" do
    let(:event) { double }

    let(:hint) { double }

    before { expect(Sentry).to receive(:send_event).with(event, hint) }

    specify { expect { subject.perform(event, hint) }.not_to raise_error }
  end
end
