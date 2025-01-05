# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateDogmaAttributeJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:attribute_id) { double }

    before do
      #
      # Eve::DogmaAttributeImporter.new(attribute_id).import
      #
      expect(Eve::DogmaAttributeImporter).to receive(:new).with(attribute_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(attribute_id) }.not_to raise_error }
  end
end
