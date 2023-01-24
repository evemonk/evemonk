# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::Alliances, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:esi) { instance_double(EveOnline::ESI::Alliances, not_modified?: false) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(subject).to receive(:import_new_alliances) }

      before { expect(subject).to receive(:remove_old_alliances) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::Alliances) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::Alliances) }

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_alliances" do
    let(:eve_alliance_ids) { double }

    before { expect(Eve::Alliance).to receive(:ids).and_return(eve_alliance_ids) }

    let(:alliance_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::Alliances,
        alliance_ids: alliance_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_alliance_id_to_create) { double }

    let(:eve_alliance_ids_to_create) { [eve_alliance_id_to_create] }

    before { expect(alliance_ids).to receive(:-).with(eve_alliance_ids).and_return(eve_alliance_ids_to_create) }

    before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).with(eve_alliance_id_to_create) }

    specify { expect { subject.send(:import_new_alliances) }.not_to raise_error }
  end

  describe "#remove_old_alliances" do
    let(:alliance_id) { double }

    let(:alliance_ids) { [alliance_id] }

    let(:esi) do
      instance_double(EveOnline::ESI::Alliances,
        alliance_ids: alliance_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_alliance_ids) { double }

    before { expect(Eve::Alliance).to receive(:ids).and_return(eve_alliance_ids) }

    let(:alliance_id_to_remove) { double }

    let(:alliance_ids_to_remove) { [alliance_id_to_remove] }

    before { expect(eve_alliance_ids).to receive(:-).with(alliance_ids).and_return(alliance_ids_to_remove) }

    let(:corporation_id) { double }

    let(:corporation) { instance_double(Eve::Corporation, corporation_id: corporation_id) }

    let(:corporations) { [corporation] }

    let(:eve_alliance) { instance_double(Eve::Alliance, corporations: corporations) }

    before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(id: alliance_id_to_remove).and_return(eve_alliance) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id) }

    before { expect(eve_alliance).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_alliances) }.not_to raise_error }
  end
end
