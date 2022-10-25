# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateAlliancesCorporationsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when eve_update_alliances_corporations_job enabled" do
      before { Flipper.enable(:eve_update_alliances_corporations_job) }

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

    context "when eve_update_alliances_corporations_job disabled" do
      before { Flipper.disable(:eve_update_alliances_corporations_job) }

      before { expect(Eve::AlliancesCorporationsImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
