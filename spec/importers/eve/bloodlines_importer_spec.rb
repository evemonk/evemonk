# frozen_string_literal: true

require "rails_helper"

describe Eve::BloodlinesImporter do
  describe "#import" do
    context "when fresh data available" do
      let(:url) { double }

      let(:new_etag) { double }

      let(:bloodline_id) { double }

      let(:as_json) { double }

      let(:bloodline) { instance_double(EveOnline::ESI::Models::Bloodline, bloodline_id: bloodline_id, as_json: as_json) }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseBloodlines,
          not_modified?: false,
          url: url,
          etag: new_etag,
          bloodlines: [bloodline])
      end

      before { expect(EveOnline::ESI::UniverseBloodlines).to receive(:new).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      let(:eve_bloodline) { instance_double(Eve::Bloodline) }

      before { expect(Eve::Bloodline).to receive(:find_or_initialize_by).with(bloodline_id: bloodline_id).and_return(eve_bloodline) }

      before { expect(eve_bloodline).to receive(:update!).with(as_json) }

      before { expect(etag).to receive(:update!).with(etag: new_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseBloodlines,
          not_modified?: true,
          url: url)
      end

      before { expect(EveOnline::ESI::UniverseBloodlines).to receive(:new).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Bloodline).not_to receive(:find_or_initialize_by) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
