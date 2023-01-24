# frozen_string_literal: true

require "rails_helper"

describe Eve::NpcCorporationsImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationNPC, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationNPC, not_modified?: false) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(subject).to receive(:update_npc_corporation_list) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationNPC) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationNPC) }

      before { expect(EveOnline::ESI::CorporationNPC).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#update_npc_corporation_list" do
    let(:corporation_npc_id) { double }

    let(:corporation_npc_ids) { [corporation_npc_id] }

    let(:esi) { instance_double(EveOnline::ESI::CorporationNPC, corporation_npc_ids: corporation_npc_ids) }

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:corporation) { instance_double(Eve::Corporation) }

    before { expect(Eve::Corporation).to receive(:find_or_initialize_by).with(corporation_id: corporation_npc_id).and_return(corporation) }

    before { expect(corporation).to receive(:assign_attributes).with(npc: true) }

    before { expect(corporation).to receive(:save!) }

    specify { expect { subject.send(:update_npc_corporation_list) }.not_to raise_error }
  end
end
