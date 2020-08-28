# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationLoyaltyStoreImporter do
  let(:corporation_id) { double }

  subject { described_class.new(corporation_id) }

  describe "#initialize" do
    its(:corporation_id) { should eq(corporation_id) }
  end

  describe "#import" do
    let(:eve_corporation) { instance_double(Eve::Corporation) }

    before do
      expect(Eve::Corporation).to receive(:find_by!)
        .with(corporation_id: corporation_id)
        .and_return(eve_corporation)
    end

    context "when fresh data available" do
      let(:url) { double }

      let(:new_etag) { double }

      let(:as_json) { double }

      let(:loyalty_store_offer) { instance_double(EveOnline::ESI::Models::LoyaltyStoreOffer, as_json: as_json) }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationLoyaltyStoreOffers,
          not_modified?: false,
          url: url,
          etag: new_etag,
          offers: [loyalty_store_offer],
          response: response)
      end

      before { expect(EveOnline::ESI::CorporationLoyaltyStoreOffers).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("e3f6a76b4a1287f54966c6253f8f5d6ac6460bc43d47570331b43e0b") }

      before do
        #
        # eve_corporation.loyalty_store_offers.destroy_all
        #
        expect(eve_corporation).to receive(:loyalty_store_offers) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      before do
        #
        # eve_corporation.loyalty_store_offers.create!(offer.as_json)
        #
        expect(eve_corporation).to receive(:loyalty_store_offers) do
          double.tap do |a|
            expect(a).to receive(:create!).with(as_json)
          end
        end
      end

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
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
