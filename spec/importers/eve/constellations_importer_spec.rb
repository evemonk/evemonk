# frozen_string_literal: true

require "rails_helper"

describe Eve::ConstellationsImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:import_new_constellations) }

    before { expect(subject).to receive(:remove_old_constellations) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseConstellations) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseConstellations) }

      before { expect(EveOnline::ESI::UniverseConstellations).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
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

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_constellation_id_to_create) { double }

    let(:eve_constellation_ids_to_create) { [eve_constellation_id_to_create] }

    before { expect(constellation_ids).to receive(:-).with(eve_constellation_ids).and_return(eve_constellation_ids_to_create) }

    before { expect(Eve::UpdateConstellationJob).to receive(:perform_later).with(eve_constellation_id_to_create) }

    specify { expect { subject.send(:import_new_constellations) }.not_to raise_error }
  end

  describe "#remove_old_constellations" do
    let(:eve_constellation_ids) { double }

    before { expect(Eve::Constellation).to receive(:pluck).with(:constellation_id).and_return(eve_constellation_ids) }

    let(:constellation_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseConstellations,
        constellation_ids: constellation_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_constellation_id_to_remove) { double }

    let(:eve_constellation_ids_to_remove) { [eve_constellation_id_to_remove] }

    before { expect(eve_constellation_ids).to receive(:-).with(constellation_ids).and_return(eve_constellation_ids_to_remove) }

    let(:eve_constellation) { instance_double(Eve::Constellation) }

    before { expect(Eve::Constellation).to receive(:find_or_initialize_by).with(constellation_id: eve_constellation_id_to_remove).and_return(eve_constellation) }

    before { expect(eve_constellation).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_constellations) }.not_to raise_error }
  end
end
