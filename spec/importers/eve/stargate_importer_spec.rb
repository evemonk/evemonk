# frozen_string_literal: true

require "rails_helper"

describe Eve::StargateImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when stargate found" do
        let(:stargate_id) { double }

        subject { described_class.new(stargate_id) }

        let(:eve_stargate) { instance_double(Eve::Stargate) }

        before { expect(Eve::Stargate).to receive(:find_or_initialize_by).with(stargate_id: stargate_id).and_return(eve_stargate) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:x) { double }

        let(:y) { double }

        let(:z) { double }

        let(:position) do
          instance_double(EveOnline::ESI::Models::Position,
            x: x,
            y: y,
            z: z)
        end

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseStargate,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            position: position,
            response: response)
        end

        before { expect(EveOnline::ESI::UniverseStargate).to receive(:new).with(id: stargate_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(eve_stargate).to receive(:update!).with(json) }

        before do
          #
          # eve_stargate.position&.destroy
          #
          expect(eve_stargate).to receive(:position) do
            double.tap do |a|
              expect(a).to receive(:destroy)
            end
          end
        end

        before do
          #
          # eve_stargate.create_position!(x: esi.position.x,
          #                               y: esi.position.y,
          #                               z: esi.position.z)
          #
          expect(eve_stargate).to receive(:create_position!).with(x: x, y: y, z: z)
        end

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }

      end

      context "when stargate not found" do
        let(:stargate_id) { double }

        subject { described_class.new(stargate_id) }

        let(:eve_stargate) { instance_double(Eve::Stargate) }

        before { expect(Eve::Stargate).to receive(:find_or_initialize_by).with(stargate_id: stargate_id).and_return(eve_stargate) }

        before { expect(EveOnline::ESI::UniverseStargate).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_stargate).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      # TODO: write
    end
  end
end
