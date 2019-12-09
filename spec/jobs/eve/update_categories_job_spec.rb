# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateCategoriesJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::CategoriesImporter.new.import
      #
      expect(Eve::CategoriesImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    subject { described_class.new }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
