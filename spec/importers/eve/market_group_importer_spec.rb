# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketGroupImporter do
  describe "#initialize" do
    context "without locale" do
      let(:market_group_id) { double }

      subject { described_class.new(market_group_id) }

      its(:market_group_id) { should eq(market_group_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:market_group_id) { double }

      let(:locale) { :ru }

      subject { described_class.new(market_group_id, locale) }

      its(:market_group_id) { should eq(market_group_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    context "when fresh data available" do
      context "when market group found" do
        let(:market_group_id) { double }

        subject { described_class.new(market_group_id) }

        let(:eve_market_group) { instance_double(Eve::MarketGroup) }

        before { expect(Eve::MarketGroup).to receive(:find_or_initialize_by).with(market_group_id: market_group_id).and_return(eve_market_group) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::MarketGroup,
            url: url,
            not_modified?: false,
            etag: new_etag,
            response: response,
            as_json: json)
        end

        before { expect(EveOnline::ESI::MarketGroup).to receive(:new).with(id: market_group_id, language: "en-us").and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

        before { expect(eve_market_group).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when group not found" do
        let(:market_group_id) { double }

        subject { described_class.new(market_group_id) }

        let(:eve_market_group) { instance_double(Eve::MarketGroup) }

        before { expect(Eve::MarketGroup).to receive(:find_or_initialize_by).with(market_group_id: market_group_id).and_return(eve_market_group) }

        before { expect(EveOnline::ESI::MarketGroup).to receive(:new).with(id: market_group_id, language: "en-us").and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_market_group).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:market_group_id) { double }

      subject { described_class.new(market_group_id) }

      let(:eve_market_group) { instance_double(Eve::MarketGroup) }

      before { expect(Eve::MarketGroup).to receive(:find_or_initialize_by).with(market_group_id: market_group_id).and_return(eve_market_group) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::MarketGroup,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::MarketGroup).to receive(:new).with(id: market_group_id, language: "en-us").and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("6780e53a01c7d9715b5f445126c4f2c137da4be79e4debe541ce3ab2") }

      before { expect(eve_market_group).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
