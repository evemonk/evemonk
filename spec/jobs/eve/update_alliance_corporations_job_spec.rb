# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateAllianceCorporationsJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:id) { double }

    context "when jobs eve update_alliance_corporations enabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:update_alliance_corporations] = true }

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

    context "when jobs eve update_alliance_corporations disabled" do
      before { Rails.configuration.evemonk.jobs[:eve][:update_alliance_corporations] = false }

      before { expect(Eve::AllianceCorporationsImporter).not_to receive(:new) }

      specify { expect { subject.perform(id) }.not_to raise_error }
    end
  end
end
