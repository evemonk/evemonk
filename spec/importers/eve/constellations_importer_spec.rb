# frozen_string_literal: true

require "rails_helper"

describe Eve::ConstellationsImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::UniverseConstellations) }

    before do
      expect(EveOnline::ESI::UniverseConstellations).to receive(:new)
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
        instance_double(EveOnline::ESI::UniverseConstellations,
          not_modified?: false,
          etag: new_etag,
          url: url,
          response: response)
      end

      before do
        expect(EveOnline::ESI::UniverseConstellations).to receive(:new)
          .and_return(esi)
      end

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).to receive(:import_new_constellations) }

      before { expect(subject).to receive(:remove_old_constellations) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseConstellations,
          url: url,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::UniverseConstellations).to receive(:new)
          .and_return(esi)
      end

      let(:etag) { instance_double(Eve::Etag, etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:import_new_constellations) }

      before { expect(subject).not_to receive(:remove_old_constellations) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_new_constellations" do
    let(:eve_constellation_ids) { double }

    before { expect(Eve::Constellation).to receive(:pluck).with(:constellation_id).and_return(eve_constellation_ids) }

    let(:constellation_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseConstellations,
        constellation_ids: constellation_ids)
    end

    before { expect(EveOnline::ESI::UniverseConstellations).to receive(:new).and_return(esi) }

    let(:eve_constellation_id_to_create) { double }

    let(:eve_constellation_ids_to_create) { [eve_constellation_id_to_create] }

    before { expect(constellation_ids).to receive(:-).with(eve_constellation_ids).and_return(eve_constellation_ids_to_create) }

    before { expect(Eve::UpdateConstellationJob).to receive(:perform_later).with(eve_constellation_id_to_create) }

    specify { expect { subject.send(:import_new_constellations) }.not_to raise_error }
  end

  describe "#remove_old_constellations" do
  end
end
