# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAlliancesJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when jobs eve update_alliances enabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:update_alliances] = true }

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

    context "when jobs eve update_alliances disabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:update_alliances] = false }

      before { expect(Eve::AlliancesImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
