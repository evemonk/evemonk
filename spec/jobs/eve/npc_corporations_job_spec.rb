# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::NpcCorporationsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::NpcCorporationsImporter.new.import
      #
      expect(Eve::NpcCorporationsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
