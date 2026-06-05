# frozen_string_literal: true

require "rails_helper"

RSpec.describe UpdateCharactersJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("realtime") }

  describe "#perform" do
  end
end
