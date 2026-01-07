# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAlliancesJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    context "when eve alliances enabled" do
      before { Flipper.enable(:eve_alliances) }

      after { Flipper.disable(:eve_alliances) }

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

    context "when eve alliances disabled" do
      before { expect(Eve::AlliancesImporter).not_to receive(:new) }

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
