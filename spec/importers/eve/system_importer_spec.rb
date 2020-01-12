# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemImporter do
  describe "#initialize" do
    context "without locale" do
      let(:system_id) { double }

      subject { described_class.new(system_id) }

      its(:system_id) { should eq(system_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:system_id) { double }

      let(:locale) { :ru }

      subject { described_class.new(system_id, locale) }

      its(:system_id) { should eq(system_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    context "when fresh data available" do
      context "when system found" do
        let(:system_id) { double }

        subject { described_class.new(system_id) }

        let(:eve_system) { instance_double(Eve::System) }

        before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: system_id).and_return(eve_system) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:position_json) { double }

        let(:position) do
          instance_double(EveOnline::ESI::Models::Position,
            as_json: position_json)
        end

        let(:star_id) { double }

        let(:stargate_id) { double }

        let(:stargate_ids) { [stargate_id] }

        let(:station_id) { double }

        let(:station_ids) { [station_id] }

        let(:planet_id) { double }

        let(:asteroid_belt_id) { double }

        let(:asteroid_belt_ids) { [asteroid_belt_id] }

        let(:moon_id) { double }

        let(:moon_ids) { [moon_id] }

        let(:planet) do
          instance_double(EveOnline::ESI::Models::PlanetShort,
            planet_id: planet_id,
            asteroid_belt_ids: asteroid_belt_ids,
            moon_ids: moon_ids)
        end

        let(:planets) { [planet] }

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseSystem,
            url: url,
            not_modified?: false,
            etag: new_etag,
            response: response,
            position: position,
            star_id: star_id,
            stargate_ids: stargate_ids,
            station_ids: station_ids,
            planets: planets,
            as_json: json)
        end

        before { expect(EveOnline::ESI::UniverseSystem).to receive(:new).with(id: system_id, language: "en-us").and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_system).to receive(:update!).with(json) }

        before do
          #
          # eve_system.position&.destroy
          #
          expect(eve_system).to receive(:position) do
            double.tap do |a|
              expect(a).to receive(:destroy)
            end
          end
        end

        before do
          #
          # eve_system.create_position!(esi.position.as_json)
          #
          expect(eve_system).to receive(:create_position!).with(position_json)
        end

        before { expect(Eve::UpdateStarJob).to receive(:perform_later).with(star_id) }

        before { expect(Eve::UpdateStargateJob).to receive(:perform_later).with(stargate_id) }

        before { expect(Eve::UpdateStationJob).to receive(:perform_later).with(station_id) }

        before { expect(Eve::UpdatePlanetJob).to receive(:perform_later).with(planet_id) }

        before { expect(Eve::UpdateAsteroidBeltJob).to receive(:perform_later).with(planet_id, asteroid_belt_id) }

        before { expect(Eve::UpdateMoonJob).to receive(:perform_later).with(planet_id, moon_id) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when system not found" do
        let(:system_id) { double }

        subject { described_class.new(system_id) }

        let(:eve_system) { instance_double(Eve::System) }

        before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: system_id).and_return(eve_system) }

        before { expect(EveOnline::ESI::UniverseSystem).to receive(:new).with(id: system_id, language: "en-us").and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_system).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:system_id) { double }

      subject { described_class.new(system_id) }

      let(:eve_system) { instance_double(Eve::System) }

      before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: system_id).and_return(eve_system) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseSystem,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseSystem).to receive(:new).with(id: system_id, language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_system).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
