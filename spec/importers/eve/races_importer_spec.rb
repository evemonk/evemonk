# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::RacesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "with default locale" do
      before { VCR.insert_cassette "esi/universe/races" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.to change(Eve::Race, :count).by(6) }

      specify do
        subject.import

        race = Eve::Race.first

        expect(race.id).to eq(1)

        expect(race.faction_id).to eq(500_001)

        expect(race.description_en).to start_with("Founded on the tenets of patriotism and hard work")

        expect(race.name_en).to eq("Caldari")
      end
    end

    context "with de locale" do
      before { VCR.insert_cassette "esi/universe/races_de" }

      after { VCR.eject_cassette }

      subject { described_class.new(:de) }

      specify do
        subject.import

        race = Eve::Race.first

        expect(race.description_de).to start_with("Der Staat der Caldari gründet sich auf den Grundsätzen von Patriotismus")
      end
    end
  end
end
