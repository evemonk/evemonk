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

  describe "#import_new_constellations"

  describe "#remove_old_constellations"
end
