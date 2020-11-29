# frozen_string_literal: true

require "rails_helper"

describe Eve::SystemsImporter do
  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseSystems, not_modified?: true) }

      before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseSystems, not_modified?: false) }

      before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(esi) }

      before { expect(subject).to receive(:import_new_systems) }

      before { expect(subject).to receive(:remove_old_systems) }

      before { expect(subject).to receive(:update_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseSystems) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseSystems) }

      before { expect(EveOnline::ESI::UniverseSystems).to receive(:new).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#import_new_systems" do
    let(:eve_systems_ids) { double }

    before { expect(Eve::System).to receive(:pluck).with(:system_id).and_return(eve_systems_ids) }

    let(:universe_system_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseSystems,
        universe_system_ids: universe_system_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_system_id_to_create) { double }

    let(:eve_system_ids_to_create) { [eve_system_id_to_create] }

    before { expect(universe_system_ids).to receive(:-).with(eve_systems_ids).and_return(eve_system_ids_to_create) }

    before { expect(Eve::UpdateSystemJob).to receive(:perform_later).with(eve_system_id_to_create) }

    specify { expect { subject.send(:import_new_systems) }.not_to raise_error }
  end

  describe "#remove_old_systems" do
    let(:eve_systems_ids) { double }

    before { expect(Eve::System).to receive(:pluck).with(:system_id).and_return(eve_systems_ids) }

    let(:universe_system_ids) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::UniverseSystems,
        universe_system_ids: universe_system_ids)
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:eve_system_id_to_remove) { double }

    let(:eve_system_ids_to_remove) { [eve_system_id_to_remove] }

    before { expect(eve_systems_ids).to receive(:-).with(universe_system_ids).and_return(eve_system_ids_to_remove) }

    let(:eve_system) { instance_double(Eve::System) }

    before { expect(Eve::System).to receive(:find_or_initialize_by).with(system_id: eve_system_id_to_remove).and_return(eve_system) }

    before { expect(eve_system).to receive(:destroy!) }

    specify { expect { subject.send(:remove_old_systems) }.not_to raise_error }
  end
end
