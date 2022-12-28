# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketGroupImporter do
  let(:market_group_id) { double }

  subject { described_class.new(market_group_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:market_group_id) { should eq(market_group_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(market_group_id, locale) }

      its(:market_group_id) { should eq(market_group_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    let(:eve_market_group) { instance_double(Eve::MarketGroup) }

    before { expect(Eve::MarketGroup).to receive(:find_or_initialize_by).with({market_group_id: market_group_id}).and_return(eve_market_group) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroup, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      context "when eve market group found" do
        let(:json) { double }

        let(:esi) { instance_double(EveOnline::ESI::MarketGroup, not_modified?: false, as_json: json) }

        before { expect(subject).to receive(:esi).and_return(esi).twice }

        before { expect(eve_market_group).to receive(:update!).with(json) }

        before { expect(subject).to receive(:update_etag) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when eve market group not found" do
        before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        let(:eve_etag) { instance_double(Eve::Etag) }

        before { expect(subject).to receive(:etag).and_return(eve_etag) }

        before do
          #
          # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve MarketGroup ID #{market_group_id}")
          #
          expect(Rails).to receive(:logger) do
            double.tap do |a|
              expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve MarketGroup ID #{market_group_id}")
            end
          end
        end

        before { expect(eve_etag).to receive(:destroy!) }

        before { expect(eve_market_group).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroup) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroup) }

      before { expect(EveOnline::ESI::MarketGroup).to receive(:new).with({id: market_group_id, language: "en-us"}).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
