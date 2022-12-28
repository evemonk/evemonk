# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketPricesImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::MarketPrices, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:esi) { instance_double(EveOnline::ESI::MarketPrices, not_modified?: false) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(subject).to receive(:update_market_prices) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::MarketPrices) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::MarketPrices) }

      before { expect(EveOnline::ESI::MarketPrices).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#update_market_prices" do
    let(:type_id) { double }

    let(:json) { double }

    let(:market_price) do
      instance_double(EveOnline::ESI::Models::MarketPrice,
        type_id: type_id,
        as_json: json)
    end

    let(:esi) do
      instance_double(EveOnline::ESI::MarketPrices,
        market_prices: [market_price])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_type) { instance_double(Eve::Type) }

    before do
      expect(Eve::Type).to receive(:find_or_initialize_by)
        .with({type_id: type_id}).and_return(eve_type)
    end

    before { expect(eve_type).to receive(:update!).with(json) }

    specify { expect { subject.send(:update_market_prices) }.not_to raise_error }
  end
end
