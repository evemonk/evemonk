# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImportMissing::ForDevelopment do
  describe "#import" do
    before { expect(Eve::UpdateRacesJob).to receive(:perform_later) }

    before { expect(Eve::UpdateBloodlinesJob).to receive(:perform_later) }

    before { expect(Eve::UpdateFactionsJob).to receive(:perform_later) }

    before { expect(Eve::UpdateAncestriesJob).to receive(:perform_later) }

    before { expect(Sde::CharacterAttributesJob).to receive(:perform_later).with("static/sde/fsd/characterAttributes.yaml") }

    before { expect(Sde::IconsJob).to receive(:perform_later).with("static/sde/fsd/iconIDs.yaml") }

    before { expect(Sde::AgentsJob).to receive(:perform_later).with("static/sde/fsd/agents.yaml") }

    before do
      expect(ImportMissing::Alliances).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      expect(ImportMissing::Corporations).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      expect(ImportMissing::Ships).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      expect(ImportMissing::Systems).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      expect(ImportMissing::Stations).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before { expect(Eve::UpdateDogmaAttributesJob).to receive(:perform_later) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
