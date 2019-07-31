# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    let(:system_id) { double }

    before do
      #
      # Eve::SystemImporter.new(system_id).import
      #
      expect(Eve::SystemImporter).to receive(:new).with(system_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(system_id) }.not_to raise_error }
  end
end
