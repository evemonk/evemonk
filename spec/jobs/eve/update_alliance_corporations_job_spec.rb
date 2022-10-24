# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateAllianceCorporationsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { double }

    context "when eve_update_alliance_corporations_job enabled" do
      before { Flipper.enable(:character_job) }

      before do
        #
        # Eve::AllianceCorporationsImporter.new(id).import
        #
        expect(Eve::AllianceCorporationsImporter).to receive(:new).with(id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      specify { expect { subject.perform(id) }.not_to raise_error }
    end

    context "when eve_update_alliance_corporations_job disabled" do
      before { Flipper.disable(:eve_update_alliance_corporations_job) }

      before { expect(Eve::AllianceCorporationsImporter).not_to receive(:new) }

      specify { expect { subject.perform(id) }.not_to raise_error }
    end
  end
end
