# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when corporation found" do
        let(:corporation_id) { double }

        subject { described_class.new(corporation_id) }

        let(:eve_corporation) { instance_double(Eve::Corporation) }

        before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::Corporation,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            response: response)
        end

        before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(eve_corporation).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when corporation not found" do
        let(:corporation_id) { double }

        subject { described_class.new(corporation_id) }

        let(:eve_corporation) { instance_double(Eve::Corporation) }

        before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

        before { expect(EveOnline::ESI::Corporation).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_corporation).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:corporation_id) { double }

      subject { described_class.new(corporation_id) }

      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_id).and_return(eve_corporation) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Corporation,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::Corporation).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

      before { expect(eve_corporation).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
