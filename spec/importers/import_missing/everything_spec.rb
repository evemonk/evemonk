# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImportMissing::Everything do
  describe "#import" do
    before do
      #
      # ImportMissing::Alliances.new.import
      #
      expect(ImportMissing::Alliances).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # ImportMissing::Corporations.new.import
      #
      expect(ImportMissing::Corporations).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # ImportMissing::Ships.new.import
      #
      expect(ImportMissing::Ships).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # ImportMissing::Stations.new.import
      #
      expect(ImportMissing::Stations).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # ImportMissing::Systems.new.import
      #
      expect(ImportMissing::Systems).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
