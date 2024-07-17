# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAllianceJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { double }

    context "when jobs eve update_alliance is enabled" do
      before { Rails.application.config.evemonk[:jobs][:eve][:update_alliance] = true }

      before do
        #
        # Eve::AllianceImporter.new(id).import
        #
        expect(Eve::AllianceImporter).to receive(:new).with(id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(id) }.not_to raise_error }
    end

    context "when jobs eve update_alliance is disabled" do
      before { Rails.application.config.evemonk[:jobs][:eve][:update_alliance] = false }

      before { expect(Eve::AllianceImporter).not_to receive(:new) }

      specify { expect { subject.perform(id) }.not_to raise_error }
    end
  end
end
