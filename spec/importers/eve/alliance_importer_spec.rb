# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when alliance found" do
        let(:alliance_id) { double }

        subject { described_class.new(alliance_id) }

        let(:eve_alliance) { instance_double(Eve::Alliance) }

        before do
          expect(Eve::Alliance).to receive(:find_or_initialize_by)
            .with(alliance_id: alliance_id)
            .and_return(eve_alliance)
        end

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::Alliance,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            response: response)
        end

        before do
          expect(EveOnline::ESI::Alliance).to receive(:new)
            .with(alliance_id: alliance_id)
            .and_return(esi)
        end

        let(:etag) do
          instance_double(Eve::Etag,
            etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2")
        end

        before do
          expect(Eve::Etag).to receive(:find_or_initialize_by)
            .with(url: url)
            .and_return(etag)
        end

        before do
          expect(esi).to receive(:etag=)
            .with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2")
        end

        before { expect(eve_alliance).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when alliance not found" do
        let(:alliance_id) { double }

        subject { described_class.new(alliance_id) }

        let(:eve_alliance) { instance_double(Eve::Alliance) }

        before do
          expect(Eve::Alliance).to receive(:find_or_initialize_by)
            .with(alliance_id: alliance_id)
            .and_return(eve_alliance)
        end

        before do
          expect(EveOnline::ESI::Alliance).to receive(:new)
            .with(alliance_id: alliance_id)
            .and_raise(EveOnline::Exceptions::ResourceNotFound)
        end

        before { expect(eve_alliance).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before do
        expect(Eve::Alliance).to receive(:find_or_initialize_by)
          .with(alliance_id: alliance_id)
          .and_return(eve_alliance)
      end

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Alliance,
          url: url,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::Alliance).to receive(:new)
          .with(alliance_id: alliance_id)
          .and_return(esi)
      end

      let(:etag) do
        instance_double(Eve::Etag,
          etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2")
      end

      before do
        expect(Eve::Etag).to receive(:find_or_initialize_by)
          .with(url: url)
          .and_return(etag)
      end

      before do
        expect(esi).to receive(:etag=)
          .with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2")
      end

      before { expect(eve_alliance).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
