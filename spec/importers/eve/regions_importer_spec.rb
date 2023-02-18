# frozen_string_literal: true

require "rails_helper"

describe Eve::RegionsImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:import_new_regions) }

    before { expect(subject).to receive(:remove_old_regions) }

    specify { expect { subject.import }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRegions) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseRegions) }

      before { expect(EveOnline::ESI::UniverseRegions).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_regions" do
    let(:eve_region_ids) { double }

    before { expect(Eve::Region).to receive(:pluck).with(:id).and_return(eve_region_ids) }

    let(:universe_region_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseRegions,
        universe_region_ids: universe_region_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_region_id_to_create) { double }

    let(:eve_region_ids_to_create) { [eve_region_id_to_create] }

    before { expect(universe_region_ids).to receive(:-).with(eve_region_ids).and_return(eve_region_ids_to_create) }

    before { expect(Eve::UpdateRegionJob).to receive(:perform_later).with(eve_region_id_to_create) }

    specify { expect { subject.send(:import_new_regions) }.not_to raise_error }
  end

  describe "#remove_old_regions" do
    let(:eve_region_ids) { double }

    before { expect(Eve::Region).to receive(:pluck).with(:id).and_return(eve_region_ids) }

    let(:universe_region_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseRegions,
        universe_region_ids: universe_region_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_region_id_to_remove) { double }

    let(:eve_region_ids_to_remove) { [eve_region_id_to_remove] }

    before { expect(eve_region_ids).to receive(:-).with(universe_region_ids).and_return(eve_region_ids_to_remove) }

    let(:eve_region) { instance_double(Eve::Region) }

    before { expect(Eve::Region).to receive(:find_or_initialize_by).with(id: eve_region_id_to_remove).and_return(eve_region) }

    before { expect(eve_region).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_regions) }.not_to raise_error }
  end
end
