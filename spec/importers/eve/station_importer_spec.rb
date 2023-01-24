# frozen_string_literal: true

require "rails_helper"

describe Eve::StationImporter do
  let(:station_id) { double }

  subject { described_class.new(station_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:station_id) { should eq(station_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    let(:eve_station) { instance_double(Eve::Station) }

    before { expect(Eve::Station).to receive(:find_or_initialize_by).with(station_id: station_id).and_return(eve_station) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseStation, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      context "when eve station found" do
        let(:json) { double }

        let(:position_json) { double }

        let(:position) do
          instance_double(EveOnline::ESI::Models::Position,
            as_json: position_json)
        end

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseStation,
            not_modified?: false,
            as_json: json,
            position: position)
        end

        before { expect(subject).to receive(:esi).and_return(esi).exactly(3).times }

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

        before { expect(subject).to receive(:update_etag) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when eve station not found" do
        before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        let(:eve_etag) { instance_double(Eve::Etag) }

        before { expect(subject).to receive(:etag).and_return(eve_etag) }

        before do
          #
          # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Station ID #{station_id}")

          expect(Rails).to receive(:logger) do
            double.tap do |a|
              expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Station ID #{station_id}")
            end
          end
        end

        before { expect(eve_etag).to receive(:destroy!) }

        before { expect(eve_station).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
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
