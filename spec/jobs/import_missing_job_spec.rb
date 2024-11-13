# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImportMissingJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when jobs import_missing enabled" do
      before { Rails.configuration.evemonk.jobs[:import_missing] = true }

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

    context "when jobs import_missing disabled" do
      before { Rails.configuration.evemonk.jobs[:import_missing] = false }

      before { expect(ImportMissing::Everything).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
