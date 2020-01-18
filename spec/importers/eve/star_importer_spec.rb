# frozen_string_literal: true

require "rails_helper"

describe Eve::StarImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when star found" do
        let(:star_id) { double }

        subject { described_class.new(star_id) }

        let(:eve_star) { instance_double(Eve::Star) }

        before { expect(Eve::Star).to receive(:find_or_initialize_by).with(star_id: star_id).and_return(eve_star) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseStar,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            response: response)
        end

        before { expect(EveOnline::ESI::UniverseStar).to receive(:new).with(id: star_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(eve_star).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when star not found" do
        let(:star_id) { double }

        subject { described_class.new(star_id) }

        let(:eve_star) { instance_double(Eve::Star) }

        before { expect(Eve::Star).to receive(:find_or_initialize_by).with(star_id: star_id).and_return(eve_star) }

        before { expect(EveOnline::ESI::UniverseStar).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_star).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:star_id) { double }

      subject { described_class.new(star_id) }

      let(:eve_star) { instance_double(Eve::Star) }

      before { expect(Eve::Star).to receive(:find_or_initialize_by).with(star_id: star_id).and_return(eve_star) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseStar,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseStar).to receive(:new).with(id: star_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

      before { expect(eve_star).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
