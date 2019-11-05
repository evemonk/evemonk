# frozen_string_literal: true

require "rails_helper"

describe SentryJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:event) { double }

    before { expect(Raven).to receive(:send_event).with(event) }

    subject { described_class.new }

    specify { expect { subject.perform(event) }.not_to raise_error }
  end
end
