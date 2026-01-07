# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AlliancesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when database is empty" do
      before { VCR.insert_cassette "esi/alliances/list" }

      after { VCR.eject_cassette }

      before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).exactly(3541).times }

      specify { expect { subject.import }.not_to change(Eve::Alliance, :count) }
    end

    context "when database is not empty" do
      context "when alliance is not exists anymore" do
        let!(:alliance) { create(:eve_alliance, id: 123_456) }

        before { VCR.insert_cassette "esi/alliances/list" }

        after { VCR.eject_cassette }

        before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).at_least(1).time }

        specify { expect { subject.import }.to change(Eve::Alliance, :count).by(-1) }
      end
    end
  end

  # # private methods
  #
  # describe "#import_new_alliances" do
  #   let(:eve_alliance_ids) { double }
  #
  #   before { expect(Eve::Alliance).to receive(:ids).and_return(eve_alliance_ids) }
  #
  #   let(:alliance_ids) { double }
  #
  #   let(:esi) do
  #     instance_double(EveOnline::ESI::Alliances,
  #       alliance_ids: alliance_ids)
  #   end
  #
  #   before { expect(subject).to receive(:esi).and_return(esi) }
  #
  #   let(:eve_alliance_id_to_create) { double }
  #
  #   let(:eve_alliance_ids_to_create) { [eve_alliance_id_to_create] }
  #
  #   before { expect(alliance_ids).to receive(:-).with(eve_alliance_ids).and_return(eve_alliance_ids_to_create) }
  #
  #   before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).with(eve_alliance_id_to_create) }
  #
  #   specify { expect { subject.send(:import_new_alliances) }.not_to raise_error }
  # end
  #
  # describe "#remove_old_alliances" do
  #   let(:alliance_id) { double }
  #
  #   let(:alliance_ids) { [alliance_id] }
  #
  #   let(:esi) do
  #     instance_double(EveOnline::ESI::Alliances,
  #       alliance_ids: alliance_ids)
  #   end
  #
  #   before { expect(subject).to receive(:esi).and_return(esi) }
  #
  #   let(:eve_alliance_ids) { double }
  #
  #   before { expect(Eve::Alliance).to receive(:ids).and_return(eve_alliance_ids) }
  #
  #   let(:alliance_id_to_remove) { double }
  #
  #   let(:alliance_ids_to_remove) { [alliance_id_to_remove] }
  #
  #   before { expect(eve_alliance_ids).to receive(:-).with(alliance_ids).and_return(alliance_ids_to_remove) }
  #
  #   let(:corporation_id) { double }
  #
  #   let(:ids) { [corporation_id] }
  #
  #   let(:eve_alliance) { instance_double(Eve::Alliance) }
  #
  #   before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(id: alliance_id_to_remove).and_return(eve_alliance) }
  #
  #   before do
  #     #
  #     # eve_alliance.corporations.ids # => ids
  #     #
  #     expect(eve_alliance).to receive(:corporations) do
  #       double.tap do |a|
  #         expect(a).to receive(:ids).and_return(ids)
  #       end
  #     end
  #   end
  #
  #   before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id) }
  #
  #   before { expect(eve_alliance).to receive(:destroy!) }
  #
  #   specify { expect { subject.send(:remove_old_alliances) }.not_to raise_error }
  # end
end
