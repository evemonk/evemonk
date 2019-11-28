# frozen_string_literal: true

require "rails_helper"

describe Eve::GraphicImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when graphic found" do
        let(:graphic_id) { double }

        subject { described_class.new(graphic_id) }

        let(:eve_graphic) { instance_double(Eve::Graphic) }

        before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseGraphic,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            response: response)
        end

        before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).with(id: graphic_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

        before { expect(eve_graphic).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when graphic not found" do
        let(:graphic_id) { double }

        subject { described_class.new(graphic_id) }

        let(:eve_graphic) { instance_double(Eve::Graphic) }

        before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

        before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).with(id: graphic_id).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_graphic).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:graphic_id) { double }

      subject { described_class.new(graphic_id) }

      let(:eve_graphic) { instance_double(Eve::Graphic) }

      before { expect(Eve::Graphic).to receive(:find_or_initialize_by).with(graphic_id: graphic_id).and_return(eve_graphic) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseGraphic,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseGraphic).to receive(:new).with(id: graphic_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(eve_graphic).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
