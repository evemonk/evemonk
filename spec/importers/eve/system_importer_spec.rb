# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemImporter do
  let(:system_id) { double }

  subject { described_class.new(system_id) }

  it { should be_a(Eve::BaseImporter) }

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
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_system) { instance_double(Eve::System) }

    before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: system_id).and_return(eve_system) }

    context "when eve system found" do
      let(:json) { double }

      let(:position_json) { double }

      let(:position) do
        instance_double(EveOnline::ESI::Models::Position,
          as_json: position_json)
      end

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
          position: position,
          star_id: star_id,
          stargate_ids: stargate_ids,
          station_ids: station_ids,
          planets: planets,
          as_json: json)
      end

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

      before { expect(Eve::UpdateStargateJob).to receive(:perform_later).with(stargate_id) }

      before { expect(Eve::UpdateStationJob).to receive(:perform_later).with(station_id) }

      before { expect(Eve::UpdatePlanetJob).to receive(:perform_later).with(planet_id) }

      before { expect(Eve::UpdateAsteroidBeltJob).to receive(:perform_later).with(planet_id, asteroid_belt_id) }

      before { expect(Eve::UpdateMoonJob).to receive(:perform_later).with(planet_id, moon_id) }

      context "when esi star_id present" do
        let(:star_id) { double }

        before { expect(subject).to receive(:esi).and_return(esi).exactly(7).times }

        before { expect(Eve::UpdateStarJob).to receive(:perform_later).with(star_id) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when esi star_id is not present" do
        let(:star_id) { nil }

        before { expect(subject).to receive(:esi).and_return(esi).exactly(6).times }

        before { expect(Eve::UpdateStarJob).not_to receive(:perform_later) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when eve system not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve System ID #{system_id}")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve System ID #{system_id}")
          end
        end
      end

      before { expect(eve_system).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseSystem) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseSystem) }

      before { expect(EveOnline::ESI::UniverseSystem).to receive(:new).with(id: system_id, language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
