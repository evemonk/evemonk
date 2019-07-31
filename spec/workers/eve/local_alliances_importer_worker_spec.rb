# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalAlliancesImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
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
end
