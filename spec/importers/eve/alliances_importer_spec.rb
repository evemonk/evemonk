# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::Alliances) }

    before do
      expect(EveOnline::ESI::Alliances).to receive(:new)
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

      let(:esi) do
        instance_double(EveOnline::ESI::Alliances,
          not_modified?: false,
          etag: new_etag,
          response: response)
      end

      before do
        expect(EveOnline::ESI::Alliances).to receive(:new)
          .and_return(esi)
      end

      before do
        expect(subject).to receive(:etag)
          .and_return(etag)
          .twice
      end

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_alliances) }

      before { expect(subject).to receive(:remove_old_alliances) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
          etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:esi) do
        instance_double(EveOnline::ESI::Alliances,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::Alliances).to receive(:new)
          .and_return(esi)
      end

      before { expect(subject).to receive(:etag).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:import_new_alliances) }

      before { expect(subject).not_to receive(:remove_old_alliances) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#etag" do
    context "when @etag set" do
      let(:etag) { instance_double(Eve::Etag) }

      before { subject.instance_variable_set(:@etag, etag) }

      specify { expect(subject.send(:etag)).to eq(etag) }
    end

    context "when @etag not set" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::Alliances,
          url: url)
      end

      let(:etag) { instance_double(Eve::Etag) }

      before do
        expect(EveOnline::ESI::Alliances).to receive(:new)
          .and_return(esi)
      end

      before do
        expect(Eve::Etag).to receive(:find_or_initialize_by)
          .with(url: url)
          .and_return(etag)
      end

      specify { expect { subject.send(:etag) }.not_to raise_error }

      specify { expect { subject.send(:etag) }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end

  describe "#import_new_alliances" do
    let(:eve_alliance_ids) { double }

    before { expect(Eve::Alliance).to receive(:pluck).with(:alliance_id).and_return(eve_alliance_ids) }

    let(:alliance_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::Alliances,
        alliance_ids: alliance_ids)
    end

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

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

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(esi) }

    let(:eve_alliance_ids) { double }

    before { expect(Eve::Alliance).to receive(:pluck).with(:alliance_id).and_return(eve_alliance_ids) }

    let(:alliance_id_to_remove) { double }

    let(:alliance_ids_to_remove) { [alliance_id_to_remove] }

    before { expect(eve_alliance_ids).to receive(:-).with(alliance_ids).and_return(alliance_ids_to_remove) }

    let(:corporation_id) { double }

    let(:corporation) { instance_double(Eve::Corporation, corporation_id: corporation_id) }

    let(:corporations) { [corporation] }

    let(:eve_alliance) { instance_double(Eve::Alliance, corporations: corporations) }

    before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id_to_remove).and_return(eve_alliance) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id) }

    before { expect(eve_alliance).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_alliances) }.not_to raise_error }
  end
end
