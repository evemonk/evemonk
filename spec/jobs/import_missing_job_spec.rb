# frozen_string_literal: true

require "rails_helper"

describe ImportMissingJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when import_missing_job enabled" do
      before { Flipper.enable(:import_missing_job) }

      before do
        #
        # ImportMissing::Everything.new.import
        #
        expect(ImportMissing::Everything).to receive(:new) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform }.not_to raise_error }
    end

    context "when import_missing_job disabled" do
      before { Flipper.disable(:import_missing_job) }

      before { expect(ImportMissing::Everything).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
