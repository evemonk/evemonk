# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAlliancesCorporationsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when jobs eve update_alliances_corporations enabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:update_alliances_corporations] = true }

      before do
        #
        # Eve::AlliancesCorporationsImporter.new.import
        #
        expect(Eve::AlliancesCorporationsImporter).to receive(:new) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when jobs eve update_alliances_corporations disabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:update_alliances_corporations] = false }

      before { expect(Eve::AlliancesCorporationsImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
