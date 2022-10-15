# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateAlliancesJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when eve_update_alliances_job enabled" do
      before { Flipper.enable(:eve_update_alliances_job) }

      before do
        #
        # Eve::AlliancesImporter.new.import
        #
        expect(Eve::AlliancesImporter).to receive(:new) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when eve_update_alliances_job disabled" do
      before { Flipper.disable(:eve_update_alliances_job) }

      before { expect(Eve::AlliancesImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
