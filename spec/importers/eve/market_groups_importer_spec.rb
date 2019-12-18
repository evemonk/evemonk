# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketGroupsImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::MarketGroups) }

    before do
      expect(EveOnline::ESI::MarketGroups).to receive(:new)
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
        instance_double(EveOnline::ESI::MarketGroups,
          not_modified?: false,
          etag: new_etag,
          url: url,
          response: response)
      end

      before do
        expect(EveOnline::ESI::MarketGroups).to receive(:new)
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

      before { expect(subject).to receive(:import_new_market_groups) }

      before { expect(subject).to receive(:remove_old_market_groups) }

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
        instance_double(EveOnline::ESI::MarketGroups,
          url: url,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::MarketGroups).to receive(:new)
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

      before { expect(subject).not_to receive(:import_new_market_groups) }

      before { expect(subject).not_to receive(:remove_old_market_groups) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_new_market_groups" do
    let(:market_group_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::MarketGroups,
        market_group_ids: [market_group_id])
    end

    before do
      expect(EveOnline::ESI::MarketGroups).to receive(:new)
        .and_return(esi)
    end

    context "when eve market group not imported" do
      before do
        expect(Eve::MarketGroup).to receive(:exists?)
          .with(market_group_id: market_group_id)
          .and_return(false)
      end

      before do
        expect(Eve::UpdateMarketGroupJob).to receive(:perform_later)
          .with(market_group_id)
      end

      specify { expect { subject.send(:import_new_market_groups) }.not_to raise_error }
    end

    context "when eve alliance already imported" do
      before do
        expect(Eve::MarketGroup).to receive(:exists?)
          .with(market_group_id: market_group_id)
          .and_return(true)
      end

      before { expect(Eve::UpdateMarketGroupJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_new_market_groups) }.not_to raise_error }
    end
  end

  describe "#remove_old_market_groups" do
    let(:market_group_id) { double }

    let(:market_group_ids) { [market_group_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::MarketGroups,
        market_group_ids: market_group_ids)
    end

    before { expect(EveOnline::ESI::MarketGroups).to receive(:new).and_return(esi) }

    let(:eve_market_group_ids) { double }

    before { expect(Eve::MarketGroup).to receive(:pluck).with(:market_group_id).and_return(eve_market_group_ids) }

    let(:eve_market_group_id_to_remove) { double }

    let(:eve_market_group_ids_to_remove) { [eve_market_group_id_to_remove] }

    before { expect(eve_market_group_ids).to receive(:-).with(market_group_ids).and_return(eve_market_group_ids_to_remove) }

    let(:eve_market_group) { instance_double(Eve::MarketGroup) }

    before { expect(Eve::MarketGroup).to receive(:find_or_initialize_by).with(market_group_id: eve_market_group_id_to_remove).and_return(eve_market_group) }

    before { expect(eve_market_group).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_market_groups) }.not_to raise_error }
  end
end
