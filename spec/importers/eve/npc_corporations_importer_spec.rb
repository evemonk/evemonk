# frozen_string_literal: true

require "rails_helper"

describe Eve::NpcCorporationsImporter do
  describe "#initialize" do
    let(:esi) { instance_double(EveOnline::ESI::CorporationNPC) }

    before do
      expect(EveOnline::ESI::CorporationNPC).to receive(:new)
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
        instance_double(EveOnline::ESI::CorporationNPC,
          not_modified?: false,
          etag: new_etag,
          response: response)
      end

      before do
        expect(EveOnline::ESI::CorporationNPC).to receive(:new)
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

      before { expect(subject).to receive(:update_npc_corporation_list) }

      before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when no fresh data available" do
      let(:etag) do
        instance_double(Eve::Etag,
          etag: "97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationNPC,
          not_modified?: true)
      end

      before do
        expect(EveOnline::ESI::CorporationNPC).to receive(:new)
          .and_return(esi)
      end

      before { expect(subject).to receive(:etag).and_return(etag) }

      before do
        expect(esi).to receive(:etag=)
          .with("97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a")
      end

      before { expect(subject).not_to receive(:update_npc_corporation_list) }

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

    end
  end
end
