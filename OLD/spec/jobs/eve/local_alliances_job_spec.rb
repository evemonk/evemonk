# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalAlliancesJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when jobs eve local_alliances enabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:local_alliances] = true }

      before do
        #
        # Eve::LocalAlliancesImporter.new.import
        #
        expect(Eve::LocalAlliancesImporter).to receive(:new) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when jobs eve local_alliances disabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:local_alliances] = false }

      before { expect(Eve::LocalAlliancesImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
