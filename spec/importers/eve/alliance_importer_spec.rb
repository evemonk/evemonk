# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when alliance found" do
        let(:alliance_id) { double }

        subject { described_class.new(alliance_id) }

        let(:eve_alliance) { instance_double(Eve::Alliance) }

        before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::Alliance,
                          url: url,
                          not_modified?: false,
                          etag: new_etag,
                          as_json: json)
        end

        before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_alliance).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when alliance not found" do
        let(:alliance_id) { double }

        subject { described_class.new(alliance_id) }

        let(:eve_alliance) { instance_double(Eve::Alliance) }

        before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

        before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_alliance).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Alliance,
                        url: url,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_alliance).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
