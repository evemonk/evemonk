# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketPricesImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::MarketPrices) }

    before do
      expect(EveOnline::ESI::MarketPrices).to receive(:new)
        .and_return(esi)
    end

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
          etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:new_etag) { double }

      let(:response) { double }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::MarketPrices,
          not_modified?: false,
          etag: new_etag,
          url: url,
          response: response)
      end

      before do
        expect(EveOnline::ESI::MarketPrices).to receive(:new)
          .and_return(esi)
      end

      before do
        expect(Eve::Etag).to receive(:find_or_initialize_by)
          .with(url: url)
          .and_return(etag)
      end

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:update_market_prices) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
          etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::MarketPrices,
          url: url,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::MarketPrices).to receive(:new)
          .and_return(esi)
      end

      before do
        expect(Eve::Etag).to receive(:find_or_initialize_by)
          .with(url: url)
          .and_return(etag)
      end

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:update_market_prices) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#update_market_prices" do

  end
end
