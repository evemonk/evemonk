# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalAlliancesJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when eve alliance is enabled" do
      before { Flipper.enable(:eve_alliance) }

      after { Flipper.disable(:eve_alliance) }

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

    context "when eve alliance is disabled" do
      before { expect(Eve::LocalAlliancesImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
