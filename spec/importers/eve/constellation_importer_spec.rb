# frozen_string_literal: true

require "rails_helper"

describe Eve::ConstellationImporter do
  describe "#initialize" do
    context "without locale" do
      let(:constellation_id) { double }

      subject { described_class.new(constellation_id) }

      its(:constellation_id) { should eq(constellation_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:constellation_id) { double }

      let(:locale) { :ru }

      subject { described_class.new(constellation_id, locale) }

      its(:constellation_id) { should eq(constellation_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    context "when fresh data available" do
      context "when constellation found" do
        let(:constellation_id) { double }

        subject { described_class.new(constellation_id) }

        let(:eve_constellation) { instance_double(Eve::Constellation) }

        before { expect(Eve::Constellation).to receive(:find_or_initialize_by).with(constellation_id: constellation_id).and_return(eve_constellation) }

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
          instance_double(EveOnline::ESI::UniverseConstellation,
            url: url,
            not_modified?: false,
            etag: new_etag,
            response: response,
            position: position,
            as_json: json)
        end

        before { expect(EveOnline::ESI::UniverseConstellation).to receive(:new).with(id: constellation_id, language: "en-us").and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_constellation).to receive(:update!).with(json) }

        before do
          #
          # eve_constellation.position&.destroy
          #
          expect(eve_constellation).to receive(:position) do
            double.tap do |a|
              expect(a).to receive(:destroy)
            end
          end
        end

        before do
          #
          # eve_constellation.create_position!(x: esi.position.x,
          #                                    y: esi.position.y,
          #                                    z: esi.position.z)
          #
          expect(eve_constellation).to receive(:create_position!).with(x: x, y: y, z: z)
        end

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when constellation not found" do
        let(:constellation_id) { double }

        subject { described_class.new(constellation_id) }

        let(:eve_constellation) { instance_double(Eve::Constellation) }

        before { expect(Eve::Constellation).to receive(:find_or_initialize_by).with(constellation_id: constellation_id).and_return(eve_constellation) }

        before { expect(EveOnline::ESI::UniverseConstellation).to receive(:new).with(id: constellation_id, language: "en-us").and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_constellation).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:constellation_id) { double }

      subject { described_class.new(constellation_id) }

      let(:eve_constellation) { instance_double(Eve::Constellation) }

      before { expect(Eve::Constellation).to receive(:find_or_initialize_by).with(constellation_id: constellation_id).and_return(eve_constellation) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseConstellation,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseConstellation).to receive(:new).with(id: constellation_id, language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_constellation).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
