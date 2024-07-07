# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateCorporationAllianceHistoryJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:corporation_id) { double }

    before do
      #
      # Eve::CorporationAllianceHistoryImporter.new(corporation_id).import
      #
      expect(Eve::CorporationAllianceHistoryImporter).to receive(:new).with(corporation_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(corporation_id) }.not_to raise_error }
  end
end
