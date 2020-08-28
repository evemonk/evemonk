# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationLoyaltyStoreImporter do
  let(:corporation_id) { double }

  subject { described_class.new(corporation_id) }

  describe "#initialize" do
    its(:corporation_id) { should eq(corporation_id) }
  end

  describe "#import" do
    context "when fresh data available" do
      # TODO: write
    end

    context "when no fresh data available" do
      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before do
        expect(Eve::Corporation).to receive(:find_by!)
          .with(corporation_id: corporation_id)
          .and_return(eve_corporation)
      end

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationLoyaltyStoreOffers,
          not_modified?: true,
          url: url)
      end

      before { expect(EveOnline::ESI::CorporationLoyaltyStoreOffers).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(eve_corporation).not_to receive(:loyalty_store_offers) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
