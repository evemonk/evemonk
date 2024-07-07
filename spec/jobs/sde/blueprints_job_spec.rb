# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sde::BlueprintsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:file) { double }

    before do
      #
      # Sde::BlueprintsImporter.new(file).import
      #
      expect(Sde::BlueprintsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Sde::BlueprintsInventionMaterialsImporter.new(file).import
      #
      expect(Sde::BlueprintsInventionMaterialsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Sde::BlueprintsInventionProductsImporter.new(file).import
      #
      expect(Sde::BlueprintsInventionProductsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Sde::BlueprintsInventionSkillsImporter.new(file).import
      #
      expect(Sde::BlueprintsInventionSkillsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Sde::BlueprintsManufacturingMaterialsImporter.new(file).import
      #
      expect(Sde::BlueprintsManufacturingMaterialsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Sde::BlueprintsManufacturingProductsImporter.new(file).import
      #
      expect(Sde::BlueprintsManufacturingProductsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Sde::BlueprintsManufacturingSkillsImporter.new(file).import
      #
      expect(Sde::BlueprintsManufacturingSkillsImporter).to receive(:new).with(file) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(file) }.not_to raise_error }
  end
end
