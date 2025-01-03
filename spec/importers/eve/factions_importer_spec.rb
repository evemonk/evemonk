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
  end

  # describe "#initialize" do
  #   context "without locale" do
  #     its(:locale) { is_expected.to eq(:en) }
  #   end
  #
  #   context "with locale" do
  #     let(:locale) { :ru }
  #
  #     subject { described_class.new(locale) }
  #
  #     its(:locale) { is_expected.to eq(:ru) }
  #   end
  # end
  #
  # describe "#import" do
  #   before { expect(subject).to receive(:configure_middlewares) }
  #
  #   let(:faction_id) { double }
  #
  #   let(:json) { double }
  #
  #   let(:faction) { instance_double(EveOnline::ESI::Models::Faction, faction_id: faction_id, as_json: json) }
  #
  #   let(:esi) { instance_double(EveOnline::ESI::UniverseFactions, factions: [faction]) }
  #
  #   before { expect(subject).to receive(:esi).and_return(esi) }
  #
  #   let(:eve_faction) { instance_double(Eve::Faction) }
  #
  #   before { expect(Eve::Faction).to receive(:find_or_initialize_by).with(id: faction_id).and_return(eve_faction) }
  #
  #   let(:transformed_json) { double }
  #
  #   before { expect(json).to receive(:transform_keys).with(faction_id: :id).and_return(transformed_json) }
  #
  #   before { expect(eve_faction).to receive(:update!).with(transformed_json) }
  #
  #   specify { expect { subject.import }.not_to raise_error }
  # end
  #
  # describe "#esi" do
  #   context "when @esi is set" do
  #     let(:esi) { instance_double(EveOnline::ESI::UniverseFactions) }
  #
  #     before { subject.instance_variable_set(:@esi, esi) }
  #
  #     specify { expect(subject.esi).to eq(esi) }
  #   end
  #
  #   context "when @esi not set" do
  #     let(:esi) { instance_double(EveOnline::ESI::UniverseFactions) }
  #
  #     before { expect(EveOnline::ESI::UniverseFactions).to receive(:new).with(language: "en-us").and_return(esi) }
  #
  #     specify { expect(subject.esi).to eq(esi) }
  #
  #     specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
  #   end
  # end
end
