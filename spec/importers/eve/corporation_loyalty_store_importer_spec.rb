# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationLoyaltyStoreImporter do
  let(:corporation_id) { double }

  subject { described_class.new(corporation_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    its(:corporation_id) { should eq(corporation_id) }
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    context "when eve corporation found" do
      let(:json) { double }

      let(:loyalty_store_offer) { instance_double(EveOnline::ESI::Models::LoyaltyStoreOffer, as_json: json) }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationLoyaltyStoreOffers,
          offers: [loyalty_store_offer])
      end

      before { expect(subject).to receive(:esi).and_return(esi) }

      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before do
        expect(Eve::Corporation).to receive(:find_by!)
          .with(corporation_id: corporation_id)
          .and_return(eve_corporation)
      end

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
            expect(a).to receive(:create!).with(json)
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve corporation not found" do
      before do
        expect(Eve::Corporation).to receive(:find_by!)
          .with(corporation_id: corporation_id)
          .and_raise(ActiveRecord::RecordNotFound)
      end

      before do
        #
        # Rails.logger.info("Corporation with ID #{corporation_id} not found")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("Corporation with ID #{corporation_id} not found")
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationLoyaltyStoreOffers) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationLoyaltyStoreOffers) }

      before { expect(EveOnline::ESI::CorporationLoyaltyStoreOffers).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.not_to raise_error }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
