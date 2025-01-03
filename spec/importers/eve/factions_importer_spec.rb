# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::FactionsImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "with default locale" do
      before { VCR.insert_cassette "esi/universe/factions" }

      after { VCR.eject_cassette }

      specify { expect { subject.import }.to change(Eve::Faction, :count).by(27) }

      specify do
        subject.import

        faction = Eve::Faction.first

        expect(faction.id).to eq(500_001)

        expect(faction.corporation_id).to eq(1_000_035)

        expect(faction.description_en).to start_with("The Caldari State is ruled by several mega-corporations.")

        expect(faction.is_unique).to eq(true)

        expect(faction.militia_corporation_id).to eq(1_000_180)

        expect(faction.name_en).to eq("Caldari State")

        expect(faction.size_factor).to eq(5.0)

        expect(faction.solar_system_id).to eq(30_000_145)

        expect(faction.station_count).to eq(1_527)

        expect(faction.station_system_count).to eq(528)

        expect(faction.id).to eq(500_001)
      end
    end

    context "with de locale" do
      before { VCR.insert_cassette "esi/universe/factions_de" }

      after { VCR.eject_cassette }

      subject { described_class.new(:de) }

      specify do
        subject.import

        faction = Eve::Faction.first

        expect(faction.description_de).to start_with("Der Staat der Caldari wird von mehreren Mega-Corporations beherrscht.")
      end
    end
  end
end
