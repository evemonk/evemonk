# frozen_string_literal: true

require "rails_helper"

describe Eve::RegionsImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::UniverseRegions) }

    before do
      expect(EveOnline::ESI::UniverseRegions).to receive(:new)
        .and_return(esi)
    end

    its(:esi) { should eq(esi) }
  end

  describe "#import" do
    context "when fresh data available" do
      let(:new_etag) { double }

      let(:url) { double }

      let(:response) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseRegions,
          not_modified?: false,
          etag: new_etag,
          url: url,
          response: response)
      end

      before do
        expect(EveOnline::ESI::UniverseRegions).to receive(:new)
          .and_return(esi)
      end

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_regions) }

      before { expect(subject).to receive(:remove_old_regions) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseRegions,
          url: url,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::UniverseRegions).to receive(:new)
          .and_return(esi)
      end

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:import_new_regions) }

      before { expect(subject).not_to receive(:remove_old_regions) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_new_regions" do
    let(:eve_region_ids) { double }

    before { expect(Eve::Region).to receive(:pluck).with(:region_id).and_return(eve_region_ids) }

    let(:universe_region_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseRegions,
        universe_region_ids: universe_region_ids)
    end

    before { expect(EveOnline::ESI::UniverseRegions).to receive(:new).and_return(esi) }

    let(:eve_region_id_to_create) { double }

    let(:eve_region_ids_to_create) { [eve_region_id_to_create] }

    before { expect(universe_region_ids).to receive(:-).with(eve_region_ids).and_return(eve_region_ids_to_create) }

    before { expect(Eve::UpdateRegionJob).to receive(:perform_later).with(eve_region_id_to_create) }

    specify { expect { subject.send(:import_new_regions) }.not_to raise_error }
  end

  describe "#remove_old_regions" do
    let(:eve_region_ids) { double }

    before { expect(Eve::Region).to receive(:pluck).with(:region_id).and_return(eve_region_ids) }

    let(:universe_region_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseRegions,
        universe_region_ids: universe_region_ids)
    end

    before { expect(EveOnline::ESI::UniverseRegions).to receive(:new).and_return(esi) }

    let(:eve_region_id_to_remove) { double }

    let(:eve_region_ids_to_remove) { [eve_region_id_to_remove] }

    before { expect(eve_region_ids).to receive(:-).with(universe_region_ids).and_return(eve_region_ids_to_remove) }

    let(:eve_region) { instance_double(Eve::Region) }

    before { expect(Eve::Region).to receive(:find_or_initialize_by).with(region_id: eve_region_id_to_remove).and_return(eve_region) }

    before { expect(eve_region).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_regions) }.not_to raise_error }
  end
end
