# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::StationImporter do
  let(:station_id) { double }

  subject { described_class.new(station_id) }

  it { is_expected.to be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:station_id) { is_expected.to eq(station_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_station) { instance_double(Eve::Station) }

    before { expect(Eve::Station).to receive(:find_or_initialize_by).with(station_id: station_id).and_return(eve_station) }

    context "when eve station found" do
      let(:json) { double }

      let(:position_json) { double }

      let(:position) do
        instance_double(EveOnline::ESI::Models::Position,
          as_json: position_json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseStation,
          as_json: json,
          position: position)
      end

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(eve_station).to receive(:update!).with(json) }

      before do
        #
        # eve_station.position&.destroy
        #
        expect(eve_station).to receive(:position) do
          double.tap do |a|
            expect(a).to receive(:destroy)
          end
        end
      end

      before do
        #
        # eve_station.create_position!(esi.position.as_json)
        #
        expect(eve_station).to receive(:create_position!).with(position_json)
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve station not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Station ID #{station_id}")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Station ID #{station_id}")
          end
        end
      end

      before { expect(eve_station).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStation) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStation) }

      before { expect(EveOnline::ESI::UniverseStation).to receive(:new).with(id: station_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
