# frozen_string_literal: true

require "rails_helper"

describe Eve::MarketGroupsImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroups, not_modified?: true) }

      before { expect(EveOnline::ESI::MarketGroups).to receive(:new).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroups, not_modified?: false) }

      before { expect(EveOnline::ESI::MarketGroups).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:import_new_market_groups) }

      before { expect(subject).to receive(:remove_old_market_groups) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroups) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::MarketGroups) }

      before { expect(EveOnline::ESI::MarketGroups).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_market_groups" do
    let(:market_group_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::MarketGroups,
        market_group_ids: [market_group_id])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

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

    context "when eve market group already imported" do
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

    before { expect(subject).to receive(:esi).and_return(esi) }

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
