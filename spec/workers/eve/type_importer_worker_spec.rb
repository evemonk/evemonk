# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    let(:type_id) { double }

    before do
      #
      # Eve::TypeImporter.new(type_id).import
      #
      expect(Eve::TypeImporter).to receive(:new).with(type_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(type_id) }.not_to raise_error }
  end
end
