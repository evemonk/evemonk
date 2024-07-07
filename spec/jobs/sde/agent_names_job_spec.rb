# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sde::AgentNamesJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:file) { double }

    before do
      #
      # Sde::AgentNamesImporter.new(file).import
      #
      expect(Sde::AgentNamesImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(file) }.not_to raise_error }
  end
end
