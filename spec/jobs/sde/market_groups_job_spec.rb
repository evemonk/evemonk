# frozen_string_literal: true

require "rails_helper"

describe Sde::MarketGroupsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:file) { double }

    before do
      #
      # Sde::MarketGroupsImporter.new(file).import
      #
      expect(Sde::MarketGroupsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(file) }.not_to raise_error }
  end
end
